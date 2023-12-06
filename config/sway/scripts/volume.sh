#!/usr/bin/env bash

if [[ $# = 1 && $1 = '-h' ]]; then
    echo "Usage: $0 [<brightness>|bit|bot|up|down|jump|fall|restore] [0xa|0xb|all] [auto|manual|restore]" 
    exit 1
fi

dB=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{ print $5 }' | sed 's/%//')
isMute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{ print $2 }')

if [[ $# = 0 ]]; then
    exit 0
fi

echo $dB

if [[ $1 = up ]]; then
  dB=$(($dB+5))
elif [[ $1 = down ]]; then
  dB=$(($dB-5))
elif [[ $1 = more ]]; then
  dB=$(($dB+10))
elif [[ $1 = less ]]; then
  dB=$(($dB-10))
elif [[ $1 = big ]]; then
  dB=$(($dB+20))
elif [[ $1 = small ]]; then
  dB=$(($dB-20))
elif [[ $1 = bit ]]; then
  dB=$(($dB+1))
elif [[ $1 = bot ]]; then
  dB=$(($dB-1))
elif [[ $1 = mute ]]; then
  pactl set-sink-mute @DEFAULT_SINK@ toggle
  exit 0
fi

if [ $dB -gt 120 ]; then
  dB="120"
  echo $dB
elif [ $dB -lt 0 ]; then
  dB="0"
  echo $dB
fi


dB="$dB%"

echo $dB


pactl set-sink-volume @DEFAULT_SINK@ "$dB"

