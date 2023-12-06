#!/bin/bash

if [[ -f /tmp/${UID}_PLAYER ]]; then
    echo a
    PLAYER=$(cat /tmp/${UID}_PLAYER)
elif [[ $(playerctl -l | wc -l) -ge 1 ]]; then
    echo b
    PLAYER=$(playerctl -l | head -n 1)
else
    echo c
    #No player?
    exit 1
fi

if [[ $(playerctl -l | wc -l) -gt 1 ]]; then
    echo d
  # switch to next player in list.
    PLAYERS=()
    for player in $(playerctl -l); do
        echo e
        PLAYERS+=("$player")
    done
    echo f
    IDX=0
    for player in "${PLAYERS[@]}"; do
    
        echo g
        if [[ "$player" == "$PLAYER" ]]; then
        break
        fi
        IDX=$((IDX+1))
    done
    
    echo h
    IDX=$((IDX+1))
    if [[ $IDX -ge ${#PLAYERS[@]} ]]; then
    
        echo i
        IDX=0
    fi
    echo j
    PLAYER=${PLAYERS[$IDX]}
fi
  
  







echo $PLAYER > /tmp/${UID}_PLAYER