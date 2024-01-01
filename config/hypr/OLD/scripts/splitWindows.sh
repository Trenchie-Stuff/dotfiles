#!/bin/bash

workspaceId=`hyprctl activeworkspace -j | jq '.id'`

monitor=`hyprctl activeworkspace -j | jq '.monitor'`

echo $monitor

width=`hyprctl monitors -j | jq '.[] | select(.name == '$monitor') | .width'`
height=`hyprctl monitors -j | jq '.[] | select(.name == '$monitor') | .height'`
left=`hyprctl monitors -j | jq '.[] | select(.name == '$monitor') | .reserved[0]'`
top=`hyprctl monitors -j | jq '.[] | select(.name == '$monitor') | .reserved[1]'`
right=`hyprctl monitors -j | jq '.[] | select(.name == '$monitor') | .reserved[2]'`
bottom=`hyprctl monitors -j | jq '.[] | select(.name == '$monitor') | .reserved[3]'`

realWidth=$(($width - $left - $right))
realHeight=$(($height - $top - $bottom))

gapsIn=`hyprctl  getoption general:gaps_in -j | jq '.int'`
gapsOut=`hyprctl  getoption general:gaps_out -j | jq '.int'`
borderSize=`hyprctl  getoption general:border_size -j | jq '.int'`

clientPids=`hyprctl clients -j | jq '.[] | select(.workspace.id == '$workspaceId' and .hidden == false) | .pid'`

clientNum=`echo $clientPids | wc -w`

availWidth=$(($realWidth - $gapsIn * ($clientNum-1)*2 - $gapsOut * 2 - $borderSize * $clientNum * 2))

widths=`hyprctl clients -j | jq '.[] | select(.workspace.id == '$workspaceId' and .hidden == false) | .size[0]'`

echo $clientPids $clientNum

echo $widths


defaultWidth=$(($availWidth / $clientNum))

for pid in $clientPids; do
  #hyprctl dispatch resizewindowpixel 
  #echo $clients
  echo hyprctl dispatch resizewindowpixel exact $defaultWidth $realHeight,pid:$pid
  hyprctl dispatch resizewindowpixel exact $defaultWidth $realHeight,pid:$pid
done