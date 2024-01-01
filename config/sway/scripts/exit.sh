#!/bin/bash


if [[ $# > 0 ]]
then
    action="$1"
    
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
    elif [ $action == "Sleep" ]; then
        sleep 1
        sudo systemctl suspend
    elif [ $action == "Lock" ]; then
        sleep 1
        swaylock
    else
        :
    fi

else
    echo "Exit
Lock
Reload
Shutdown
Reboot
Sleep
Cancel"
fi
