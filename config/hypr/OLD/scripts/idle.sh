#!/bin/bash

swayidle -w \
timeout 1595 'hyprctl dispatch dpms off' \
timeout 1600 'systemctl suspend' \
resume 'hyprctl dispatch dpms on; ~/.config/hypr/scripts/fixMonitors.sh'

#timeout 450 '~/.config/hypr/scripts/lock.sh' \
