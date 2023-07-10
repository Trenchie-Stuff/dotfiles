#!/bin/bash
name=`hyprctl activewindow -j | jq '.class'`
lowerName=`echo $name | tr '[:upper:]' '[:lower:]'`
if [[ $lowerName == *"steam"* ]]; then
    :
else
    monitors=$(hyprctl monitors)
    activemonitor=$(echo $monitors | grep -B 7 "focused: yes" | awk 'NR==1 {print $2}')
    activews=$(echo $monitors | grep -A 2 "$activemonitor" | awk 'NR==3 {print $1}' RS='(' FS=')')
    hyprctl dispatch workspace 9
    killall -9 Discord
    swaylock
    discord&
    hyprctl dispatch workspace activews
fi
