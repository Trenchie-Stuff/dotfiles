#!/usr/bin/env bash

TAG1=("foot" "firefox")
TAG2=("firefox")
TAG3=("code-oss")
TAG4=("")
TAG5=("mpv --player-operation-mode=pseudo-gui")
TAG6=("steam-native")
TAG7=("krita")
TAG8=("mailspring --no-sandbox")
TAG9=("discord --enable-features=UseOzonePlatform" "/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=slack --file-forwarding com.slack.Slack @@u %U @@")
#Lookup Focused tag
#monitorInfo=hyprctl monitors
TAG="$(hyprctl monitors -j | jq '.[] | select(.focused == true)' | jq '.activeWorkspace.id')"

#Executes application based on number of focused tag
case "$TAG" in 
  1) $TAG1 &> /dev/null ;;
  2) $TAG2 &> /dev/null ;;
  3) $TAG3 &> /dev/null ;;
  4) $TAG4 &> /dev/null ;;
  5) $TAG5 &> /dev/null ;;
  6) $TAG6 &> /dev/null ;;
  7) $TAG7 &> /dev/null ;;
  8) $TAG8 &> /dev/null ;;
  9) $TAG9 &> /dev/null ;;
esac
