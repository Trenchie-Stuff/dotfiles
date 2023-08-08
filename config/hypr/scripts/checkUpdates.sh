#!/usr/bin/env bash

loop="true"

if [ "$1" = "once" ]; then  
  loop="false"
fi

#if [ "$isNormal" = "false" ]; then
#  notify-send -a '~/dotfiles' -i vcs-update-required "$message"
#else
#fi

runCheck() {
    git -C ~/dotfiles fetch

    touch ~/.cache/dotFilesUpdateChecked.touch

    message=""

    hasChanges=$(git status --untracked-files=no -s | wc -l)

    isNormal="true"

    icon="vcs-normal"

    git -C ~/dotfiles merge-base --is-ancestor origin/main HEAD

    if [ $? -eq 0 ]; then
      message=""
    else
      message="Update available"
      icon="vcs-update-required"
      #notify-send -a '~/dotfiles' -i vcs-update-required "Update available."
    fi

    git -C ~/dotfiles merge-base --is-ancestor HEAD origin/main

    if [ $? -eq 0 ] && [ "$message" = "" ]; then
      message=""
    else
      message="$message, but changes not pushed"
      icon="vcs-locally-modified"
      #notify-send -a '~/dotfiles' -i vcs-update-required "Update available."
    fi

    if [ $hasChanges -ne 0 ]; then
      isNormal="false"
      if [ "$icon" != "vcs-normal" ]; then
        icon="vcs-conflicting"  
      else
        icon="vcs-locally-modified-unstaged"
      fi;
      if [ "$message" = "" ]; then
        message="Changes detected."
      else
        message="$message, but changes detected."
      fi
    fi
    if [ "$message" = "" ]; then
      message="No changes detected."
    else
      message="$message."
    fi

    notify-send -a '~/dotfiles' -i "$icon" "$message"
}

update_daemon() {
    if [ "$loop" = "true" ]; then
      while :; do 
        runCheck;
        sleep 18000;
      done;
    else
      runCheck
    fi;
}

update_daemon
