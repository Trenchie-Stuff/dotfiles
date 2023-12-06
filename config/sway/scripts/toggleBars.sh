#!/bin/bash
if [[ "$(swaymsg -t get_bar_config 20 | jq -r ".mode")" = "dock" ]]; then
  swaymsg bar mode invisible 20
  kill $(ps -Alf | grep waybar | grep styleBar | awk '{ print $4 }')
elif [[ "$(swaymsg -t get_bar_config 10 | jq -r ".mode")" = "dock" ]]; then
  swaymsg bar mode invisible 10
else 
  swaymsg bar mode dock 20
  waybar -c ~/.config/waybar/styleBar &
  swaymsg bar mode dock 10
fi;