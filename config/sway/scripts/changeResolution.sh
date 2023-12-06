#!/bin/bash

curWidth=$(swaymsg -t get_outputs -r | jq '.[] | select(.rect.x == 0).rect.width')

if [[ $curWidth == 3440 ]]; then
    swaymsg output "\"ASR PG34WQ15R2B 0x00000133\"" resolution 2560x1440@165Hz position 0 0
    swaymsg output "\"HP Inc. HP E27u G4 CN424204BW\"" resolution 2560x1440 position 2560 0
    swaymsg output "\"ASR PG34WQ15R2B 0x00000133\"" bg ~/Wallpapers/2560.png fill
    
else
    swaymsg output "\"ASR PG34WQ15R2B 0x00000133\"" resolution 3440x1440@165Hz position 0 0
    swaymsg output "\"HP Inc. HP E27u G4 CN424204BW\"" resolution 2560x1440 position 3440 0
    swaymsg output "\"ASR PG34WQ15R2B 0x00000133\"" bg ~/Wallpapers/3440.png fill
fi