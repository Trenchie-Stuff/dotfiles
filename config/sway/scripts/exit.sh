#!/bin/bash

action=$(echo "Exit
Reload
Shutdown
Reboot
Sleep
Cancel" | bemenu -c -p 'LCARS' -P '>' -i -l 20 -w --fixed-height --scrollbar always -B 4 \
-s --bdr '#2266DD' \
--margin 500 --fn 'Antonio 20' \
--scb '#000000' --scf '#b59cce' \
--tb '#000000' --tf '#b59cce' \
--fb '#000000' --ff '#b59cce' \
--cb '#b59cce' --cf '#000000ff' \
--nb '#b59cce' --nf '#000000' \
--fbb '#b59cce' --fbf '#000000' \
--hb '#553c6e' --hf '#ffffff' \
--sb '#f6ef95' --sf '#000000' \
--ab '#957cae' --af '#000000')
#Scroll
#Title
#filter
#cursor
#normal
#high
#selected
#alternating

if [ $action == "Exit" ]; then
    # echo ".$action."
    swaymsg exit
elif [ $action == "Reload" ]; then
    # echo ",$action,"
    swaymsg reload
elif [ $action == "Reboot" ]; then
    sleep 1
    sudo systemctl reboot
elif [ $action == "Shutdown" ]; then
    sleep 1
    sudo systemctl poweroff
elif [ $action == "Suspend" ]; then
    sleep 1
    sudo systemctl suspend
else
    :
fi
