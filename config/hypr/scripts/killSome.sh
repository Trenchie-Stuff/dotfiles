#!/bin/bash

name=`hyprctl activewindow -j | jq '.class'`
lowerName=`echo $name | tr '[:upper:]' '[:lower:]'`
if [[ $lowerName == *"steam"* ]]; then
    hyprctl dispatch cyclenext
else
    hyprctl dispatch killactive
fi