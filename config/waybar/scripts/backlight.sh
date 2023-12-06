#!/usr/bin/env bash
module() {
#output eww widget
    NBRT=$(ddcutil getvcp 10 --sleep-multiplier 0.5 --bus 0xa --noverify --terse)
    if [[ $? = 0 ]]; then
            if [[ $NBRT != $BRT ]]; then
                BRT=$(echo "$NBRT" | awk '{print $4}')
                echo "󰃞 $BRT"
            fi
        return 0
    else
        return 1;
    fi
}

module

while [ $? = 1 ]
do
    sleep 1
    echo "..."
    module
done

while true
do
    sleep 3
    module
done
