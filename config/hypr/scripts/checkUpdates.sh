#!/usr/bin/env bash

  
git -C ~/dotfiles fetch

touch ~/.cache/dotFilesUpdateChecked.touch

git -C ~/dotfiles merge-base --is-ancestor origin/main HEAD

if [ $? -eq 0 ]; then
  notify-send -a '~/dotfiles' -i vcs-normal "Up to date."
else
  notify-send -a '~/dotfiles' -i vcs-update-required "Update available."
fi

update_daemon() {
	while :; do 
  
    git -C ~/dotfiles fetch
    
    touch ~/.cache/dotFilesUpdateChecked.touch
    
    git -C ~/dotfiles merge-base --is-ancestor origin/main HEAD

    if [ $? -eq 0 ]; then
      :
    else
      notify-send -a '~/dotfiles' -i vcs-update-required "Update available."
    fi
    sleep 3600;
    
  done;
}

update_daemon