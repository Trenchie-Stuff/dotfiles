#!/usr/bin/env bash

if [[ $# = 1 && $1 = '-h' ]]; then
    echo "Usage: $0 [<brightness>|bit|bot|up|down|jump|fall|restore] [0xa|0xb|all] [auto|manual|restore]" 
    exit 1
fi

if [[ $# = 0 ]]; then
    cB=$(ddcutil 'getvcp' '10' --sleep-multiplier '0.1' --bus '0xa' --noverify -t | awk '{print $4}')
    echo $cB
    exit 0
fi


if [[ $1 = up ]]; then
  sB="+ 5"
elif [[ $1 = down ]]; then
  sB="- 5"
elif [[ $1 = top ]]; then
  sB="+ 20"
elif [[ $1 = bottom ]]; then
  sB="- 20"
elif [[ $1 = charm ]]; then
  sB="+ 2"
elif [[ $1 = strange ]]; then
  sB="- 2"
else
  sB=$1
fi

# echo $currentBrightness

if [[ $2 = 'all' ]]; then
  ddcutil setvcp 10 $sB --sleep-multiplier 0.1 --bus 0xa --noverify -t
  ddcutil setvcp 10 $sB --sleep-multiplier 0.1 --bus 0x9 --noverify -t
  ddcutil setvcp 10 $sB --sleep-multiplier 0.1 --bus 0x10 --noverify
else
  ddcutil setvcp 10 $sB --sleep-multiplier 0.1 --bus $2 --noverify
fi

if [[ $3 = 'manual' ]]; then
  cB=$(ddcutil 'getvcp' '10' --sleep-multiplier '0.1' --bus '0xa' --noverify -t | awk '{print $4}')
  echo "swaymsg \"set \$currentBrightness $cB\""
  swaymsg "set \$currentBrightness $cB"
fi
