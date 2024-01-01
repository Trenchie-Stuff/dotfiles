#!/bin/bash

selected="$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]) | select(.name != null) | select(.type == "con") | .name? + " : " + (.id|tostring)' | grep -e "[0-9]* ." | sed 's/^/ /' | bemenu)"
selId=$(echo "$selected" | awk '{ print $NF }')
swaymsg "[con_id=$selId]" focus