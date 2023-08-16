#!/usr/bin/env bash

git submodule init
git submodule update

mkdir -p ~/.config

shopt -s dotglob

clear

echo Updating home directory...

for f in home/*; do
  if [[ -L "$HOME/$(basename "$f")" ]]; then
    echo "  ✅ $(basename "$f")";
    continue;
  fi;
  
  if [[ $yn != 'a' ]] && [[ $yn != 's' ]]; then
    read -n1 -p "  > Symlink ~/$(basename "$f")? (yes/no/all/quit/skip section) " yn
    echo -n -e "\033[2K\033[0E\033[1A"
  fi
  
  case $yn in
    all|a|y|yes)
      if [[ -L "$HOME/$(basename "$f")" ]]; then
        rm $HOME/$(basename "$f");
      fi;
      if [[ -d "$HOME/$(basename "$f")" ]]; then
        echo "  Moving existing $HOME/$(basename "$f") to $HOME/$(basename "$f")_old";
        mv $HOME/$(basename "$f") $HOME/$(basename "$f")_old;
      fi;
      if [[ -f "$HOME/$(basename "$f")" ]]; then
        echo "  Moving existing $HOME/$(basename "$f") to $HOME/$(basename "$f")_old";
        mv $HOME/$(basename "$f") $HOME/$(basename "$f")_old;
      fi;
      ln -sf `pwd`/$f $HOME/$(basename "$f");
      echo "  ✅ $(basename "$f")";;
    n|s) 
      echo "  ➖ $(basename "$f")";;
    q|quit)
      echo "FINE then, I don't need you ANYWAY!";
      exit 0;;
    *)
      echo "Didn't understand, panicking.";
      exit 1;;
  esac
done;

yn=""

echo Updating .config directory entries...



for f in config/*; do

  if [[ -L "$HOME/.config/$(basename "$f")" ]]; then
    echo "  ✅ $(basename "$f")";
    continue;
  fi;
  
  if [[ $yn != 'a' ]] && [[ $yn != 's' ]]; then
    read -n1 -p "  > Symlink .config/$(basename "$f")? (yes/no/all/quit/skip) " yn
    echo -n -e "\033[2K\033[0E\033[1A"
  fi
  case $yn in
    all|a|y|yes)
      if [[ -L "$HOME/.config/$(basename "$f")" ]]; then
        rm $HOME/.config/$(basename "$f");
      fi;
      if [[ -d "$HOME/.config/$(basename "$f")" ]]; then
        echo "  Moving existing $HOME/.config/$(basename "$f") to $HOME/.config/$(basename "$f")_old";
        mv $HOME/.config/$(basename "$f") $HOME/.config/$(basename "$f")_old;
      fi;
      if [[ -f "$HOME/.config/$(basename "$f")" ]]; then
        echo "  Moving existing $HOME/.config/$(basename "$f") to $HOME/.config/$(basename "$f")_old";
        mv $HOME/.config/$(basename "$f") $HOME/.config/$(basename "$f")_old;
      fi;
      ln -sf `pwd`/$f $HOME/.config/$(basename "$f");
      echo "  ✅ $(basename "$f")";;
    n|s) 
      echo "  ➖ $(basename "$f")";;
    q|quit)
      echo 'WELL THEN, FINE.';
      exit 0;;
    *)
      echo "Didn't understand, panicking.";
      exit 1;;
  esac
done;

yn=""

echo Installing packages...

pacman -Qqs yay > /dev/null

yayInstalled=$?

if [[ $? -eq 0 ]]; then
  echo "  ✅ yay";
else 
  read -n1 -p "  > Install yay (required for other packages)? (yes/no) " yn
  echo -n -e "\033[2K\033[0E\033[1A"
  if [[ $yn == 'y' ]]; then
    cd yay
    makepkg -si
    yayInstalled=$?
    cd ..
    yay -Sy;
    echo "  ✅ yay";
  else
    echo "  ➖ yay";
  fi
fi


if [[ $yayInstalled -eq 0 ]]; then
  declare -a PACKAGES=(
    bc
    rofi-bluetooth
    tmux
    rustup
    scdoc 
    nerd-fonts-inter
#    nerd-fonts-meta
    hyprland-git
    eww-wayland
    fuzzel
    rofi
    dunst
    mpvpaper-git
    socat
    neovim
    emacs
    geticons
    macchina
    nitch
    trayer
    rofi-brbw
    wlogout
    swaylock-effects-git
    swayidle
    zsh
#    code-translucent
    visual-studio-code-bin
    )
  instChoices=();
  for i in ${!PACKAGES[@]}; do
    p="${PACKAGES[$i]}"
    pacman -Qqs $p > /dev/null
    if [[ $? -eq 0 ]]; then
      echo "  ✅ $p";
      continue;
    fi
    if [[ $yn != 'a' ]] || [[ $yn != 'q' ]] || [[ $yn != 's' ]]; then
      read -n1 -p "  > Install $p? (yes/no/all/quit/skip section) " yn
      echo -n -e "\033[2K\033[0E\033[1A"
    fi
    case $yn in
      a|y)
        instChoices+=( $p );;
      q)
        echo 'To hell with you, buddy!';
        exit 0;;
      n|s)
        echo "  ➖ $p";;
    esac
  done
  echo "Installing ${#instChoices[@]} packages..."
  for i in ${!instChoices[@]}; do
    p="${instChoices[$i]}"
    yay -S --noconfirm $p 2> /dev/null > /dev/null
    echo "  ✅ $p";
    if [[ $p == 'nvm' ]]; then
      read -n1 -p "  .  > Install current Node.JS LTS with nvm?" ync
      echo -n -e "\033[2K\033[0E\033[1A"
      if [[ $ync == 'y' ]]; then
        source /usr/share/nvm/init-nvm.sh
        nvm install --lts
      fi;
    fi
    if [[ $p == 'zsh' ]]; then
      read -n1 -p "  .  > Switch your default shell to zsh?" ync
      echo -n -e "\033[2K\033[0E\033[1A"
      if [[ $ync == 'y' ]]; then
        chsh -s /bin/zsh
      fi;
    fi
    if [[ $p == 'rustup' ]]; then
      read -n1 -p "  .  > Configure rustup? (required for fonts)" ync
      echo -n -e "\033[2K\033[0E\033[1A"
      if [[ $ync == 'y' ]]; then
        rustup default stable
      fi
    fi
  done

fi



ln -sf `pwd`/powerlevel10k $HOME/.oh-my-zsh/custom/themes/powerlevel10k
echo "Creating Directories..."
declare -a DIRECTORIES=(
  "$HOME/Wallpapers"
  "$HOME/Wallpapers/Clips"
  "$HOME/farts"
  )
for i in ${!DIRECTORIES[@]}; do
  p="${DIRECTORIES[$i]}"
  if [[ -d "$p" ]];
  then
    :
  else
    mkdir -p "$p"
  fi
  echo "  ✅ $p ";
done;

sudo sed -iE 's/^#Experimental = .*$/Experimental = true/' /etc/bluetooth/main.conf

echo "Log out and log back in. Run 'Hyprland' to start UI."

