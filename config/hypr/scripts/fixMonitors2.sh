#!/bin/sh

BOT=`wlr-randr | grep '^[^ ]' | grep PG34WQ15R2B | sed 's/ .*//'`
TOP=`wlr-randr | grep '^[^ ]' | grep E27u | sed 's/ .*//'`

BOTID=$(hyprctl monitors -j | jq -rc ".[] | select( .name == \"$BOT\").id")
TOPID=$(hyprctl monitors -j | jq -rc ".[] | select( .name == \"$TOP\").id")

cat ~/.config/hypr/configs/monitors.conf_template | sed -e "s/\$BOT/$BOT/" -e "s/\$TOP/$TOP/" > ~/.config/hypr/configs/monitors.conf

cat ~/.config/hypr/eww/eww.yuck_template | sed -e "s/{{monitor0}}/monitor $BOTID/g" -e "s/{{monitor1}}/monitor $TOPID/g" > ~/.config/hypr/eww/eww.yuck
echo $BOT $BOTID
echo $TOP $TOPID

rm ~/.config/hypr/scripts/fixMonitors.sh
ln -s ~/.config/hypr/scripts/fixMonitors2.sh ~/.config/hypr/scripts/fixMonitors.sh


