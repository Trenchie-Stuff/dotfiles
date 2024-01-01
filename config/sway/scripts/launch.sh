#!/bin/bash


if [[ $# > 0 ]]
then
    selected="$1"
    if [[ "$selected" =~ ^" " ]]; then
        selId=$(echo "$selected" | awk '{ print $NF }')
        swaymsg "[con_id=$selId]" focus
    else
        swaymsg exec "$selected"
    fi
else

    execs=$(dmenu_path)

    # Get regular windows
    #regular_windows=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]) | select(.name != null) | select(.type == "con") | (.id|tostring) + " " + .name?' | grep -e "[0-9]* ." | sed 's/^/ /')
    regular_windows=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]) | select(.name != null) | select(.type == "con") | .name? + " : " + (.id|tostring)' | grep -e "[0-9]* ." | sed 's/^/ /')
    # | sed -E 's/([^-—]+)[-—].*[-—]([^-—]+)/\1 : \2/g')

    enter=$'\n'
    all_options="$regular_windows$enter$execs"
    
    echo "$all_options"
fi

