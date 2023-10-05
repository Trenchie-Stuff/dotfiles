#!/usr/bin/env bash

if [[ $# = 0 ]]; then
    echo "Usage: $0 <brightness>|up|down|jump|fall"
    exit 1
fi

if [[ $1 = "up" ]]; then
    ddcutil setvcp 10 + 5 --sleep-multiplier 0.1 --bus 0xa --noverify
    ddcutil setvcp 10 + 5 --sleep-multiplier 0.1 --bus 0xb --noverify
elif [[ $1 = "down" ]]; then
    ddcutil setvcp 10 - 5 --sleep-multiplier 0.1 --bus 0xa --noverify
    ddcutil setvcp 10 - 5 --sleep-multiplier 0.1 --bus 0xb --noverify
elif [[ $1 = "jump" ]]; then
    ddcutil setvcp 10 + 20 --sleep-multiplier 0.1 --bus 0xa --noverify
    ddcutil setvcp 10 + 20 --sleep-multiplier 0.1 --bus 0xb --noverify
elif [[ $1 = "fall" ]]; then
    ddcutil setvcp 10 - 20 --sleep-multiplier 0.1 --bus 0xa --noverify
    ddcutil setvcp 10 - 20 --sleep-multiplier 0.1 --bus 0xb --noverify
else
    ddcutil setvcp 10 $1 --sleep-multiplier 0.1 --bus 0xa --noverify
    ddcutil setvcp 10 $1 --sleep-multiplier 0.1 --bus 0xb --noverify
fi

