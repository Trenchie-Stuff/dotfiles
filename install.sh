#!/usr/bin/env bash

git submodule init
git submodule update

mkdir -p ~/.config

shopt -s dotglob

for f in home/*; do
  if [[ $yn != 'a' ]]; then
    read -p "Install $f? (yes/no/all/quit) " yn
  fi
  case $yn in
    all|a|y|yes)
      ln -sf `pwd`/$f $HOME/`basename $f`;;
    n|no) 
      echo "skipping...";;
    q|quit)
      echo 'exitting.';
      exit 0;;
    *)
      echo "Didn't understand, panicking.";
      exit 1;;
  esac
done;

yn=""

for f in config/*; do
  if [[ $yn != 'a' ]]; then
    read -p "Install $f? (yes/no/all) " yn
  fi
  case $yn in
    all|a|y|yes)
      ln -sf `pwd`/$f $HOME/.config/`basename $f`;;
    n|no) 
      echo "skipping...";;
    q|quit)
      echo 'exitting.';
      exit 0;;
    *)
      echo "Didn't understand, panicking.";
      exit 1;;
  esac
done;

read -p "Install yay (for Arch-ish, updates pacman cache)? (yes/no) " yn
if [[ $yn == 'y' ]]; then
  cd yay
  makepkg -si
  cd ..
  PACKAGES="hyprland-git"
  read -p "Install ? (yes/no) " yn
  
fi  


ln -sf `pwd`/powerlevel10k $HOME/.oh-my-zsh/custom/themes/powerlevel10k
source /usr/share/nvm/init-nvm.sh
nvm install --lts
chsh -s /bin/zsh


echo "Log out and log back in."

