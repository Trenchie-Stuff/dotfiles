#!/usr/bin/env bash

git submodule init
git submodule update

mkdir -p ~/.config

shopt -s dotglob

for f in home/*; do
  if [[ $yn != 'a' ]] && [[ $yn != 's' ]]; then
    read -p "Install $f? (yes/no/all/quit/skip) " yn
  fi
  case $yn in
    all|a|y|yes)
      if [[ -L $HOME/`basename $f` ]]; then
        rm $HOME/`basename $f`;
      fi;
      ln -sf `pwd`/$f $HOME/`basename $f`;;
    n|no) 
      echo "skipping...";;
    q|quit)
      echo 'exitting.';
      exit 0;;
    s|skip)
      ;;
    *)
      echo "Didn't understand, panicking.";
      exit 1;;
  esac
done;

yn=""

for f in config/*; do
  if [[ $yn != 'a' ]] && [[ $yn != 's' ]]; then
    read -p "Install $f? (yes/no/all/quit/skip) " yn
  fi
  case $yn in
    all|a|y|yes)
      if [[ -L $HOME/.config/`basename $f` ]]; then
        rm $HOME/.config/`basename $f`;
      fi;
      ln -sf `pwd`/$f $HOME/.config/`basename $f`;;
    n|no) 
      echo "skipping...";;
    q|quit)
      echo 'exitting.';
      exit 0;;
    s|skip)
      ;;
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
  yay -Sy;
  
fi
read -p "Install and config rustup? (required for fonts)" yn
if [[ $yn == 'y' ]]; then
  yay -S rustup
  rustup default stable
fi;

PACKAGES="scdoc nerd-fonts-inter hyprland-git eww-wayland nerd-fonts fuzzel rofi dunst mpvpaper-git socat geticons macchina nitch trayer"
for p in $PACKAGES; do
  if [[ $yn != 'a' ]] || [[ $yn != 'q' ]]; then
    read -p "Install $p? (yes/no/all) " yn
  fi
  case $yn in
    all|a|y|yes)
      yay -S $p;;
    n|no|q|quit) 
      echo "skipping... $p";;
  esac
done   


ln -sf `pwd`/powerlevel10k $HOME/.oh-my-zsh/custom/themes/powerlevel10k
source /usr/share/nvm/init-nvm.sh
nvm install --lts
chsh -s /bin/zsh

mkdir -p $HOME/Wallpaper/Clips
echo Put your wallpaper images in $HOME/Wallpaper
echo Put your wallpaper videos in $HOME/Wallpaper/Clips

echo "Log out and log back in. Run 'Hyprland' to start UI."

