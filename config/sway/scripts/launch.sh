#!/bin/bash

#j4-dmenu-desktop --dmenu="bemenu -c -p 'LCARS' -P ' ' -i -l 20 -w --fixed-height --scrollbar always -s -B 4 --bdr '#2266DD' --margin 500 --fn 'Antonio 20' --scb '#000000' --scf '#b59cce' --tb '#000000' --tf '#b59cce' --fb '#000000' --ff '#b59cce' --cf '#000000' --cb '#b59cce' --nb '#b59cce' --nf '#000000' --hb '#553c6e' --hf '#ffffff' --sb '#f6ef95' --sf '#000000' --ab '#c5Acde' --af '#000000'" --term="footclient"

#exit 0

execs=$(dmenu_path)

# Get regular windows
#regular_windows=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]) | select(.name != null) | select(.type == "con") | (.id|tostring) + " " + .name?' | grep -e "[0-9]* ." | sed 's/^/ /')
regular_windows=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]) | select(.name != null) | select(.type == "con") | .name? + " : " + (.id|tostring)' | grep -e "[0-9]* ." | sed 's/^/ /')
# | sed -E 's/([^-—]+)[-—].*[-—]([^-—]+)/\1 : \2/g')

enter=$'\n'
all_options="$regular_windows$enter$execs"

# Select window with rofi
selected=$(echo "$all_options" | bemenu -c -p 'LCARS' -P ' ' -i -l 20 -w --fixed-height --scrollbar always -s -B 4 --bdr '#2266DD' --margin 500 --fn 'Antonio 20' --scb '#000000' --scf '#b59cce' --tb '#000000' --tf '#b59cce' --fb '#000000' --ff '#b59cce' --cf '#000000' --cb '#b59cce' --nb '#b59cce' --nf '#000000' --hb '#553c6e' --hf '#ffffff' --sb '#f6ef95' --sf '#000000' --ab '#c5Acde' --af '#000000')

if [[ "$selected" =~ ^" " ]]; then
    selId=$(echo "$selected" | awk '{ print $NF }')
    swaymsg "[con_id=$selId]" focus
else
    swaymsg exec "$selected"
fi

# Tell sway to focus said window
