#!/bin/bash
name=`hyprctl activewindow -j | jq '.class'`
lowerName=`echo $name | tr '[:upper:]' '[:lower:]'`
if [[ $lowerName == *"steam"* ]]; then
    :
else
    swaylock
fi
