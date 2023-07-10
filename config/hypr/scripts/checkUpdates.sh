#!/usr/bin/env bash

  

#if [ "$isNormal" = "false" ]; then
#  notify-send -a '~/dotfiles' -i vcs-update-required "$message"
#else
#fi

update_daemon() {
    while :; do 

    git -C ~/dotfiles fetch

    touch ~/.cache/dotFilesUpdateChecked.touch

    message=""

    hasChanges=$(git status --untracked-files=no -s | wc -l)

    isNormal="true"

    icon="vcs-normal"

    git -C ~/dotfiles merge-base --is-ancestor origin/main HEAD

    if [ $? -eq 0 ]; then
      message="Up to date"
    else
      message="Update available"
      icon="vcs-update-required"
      #notify-send -a '~/dotfiles' -i vcs-update-required "Update available."
    fi

    if [ $hasChanges -ne 0 ]; then
      isNormal="false"
      if [ "$icon" != "vcs-normal" ]; then
        icon="vcs-conflicting"  
      else
        icon="vcs-locally-modified"
      fi;
      message="$message, but changes detected."
    else
      message="$message."
    fi

    notify-send -a '~/dotfiles' -i "$icon" "$message"
  
    sleep 3600;
    
  done;
}

update_daemon
