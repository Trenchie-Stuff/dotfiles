#!/bin/sh
BOT=`wlr-randr | grep '^[^ ]' | grep V3L6W | sed 's/ .*//'`
TOP=`wlr-randr | grep '^[^ ]' | grep E27u | sed 's/ .*//'`

cat ~/.config/hypr/configs/monitors.conf_template | sed -e "s/\$BOT/$BOT/" -e "s/\$TOP/$TOP/" > ~/.config/hypr/configs/monitors.conf