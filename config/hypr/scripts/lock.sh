#!/bin/bash
#swaylock
#exit 0
name=`hyprctl activewindow -j | jq '.class'`
lowerName=`echo $name | tr '[:upper:]' '[:lower:]'`
if [[ $lowerName == *"steam"* ]]; then
    :
else
    monitors=$(hyprctl monitors -j)
    activews=$(hyprctl monitors -j | jq 'map(select(.focused == true)) | .[0].activeWorkspace.id')
    hyprctl dispatch workspace 9
    killall -9 Discord
    swaylock
    sleep 0.2
    discord&
    isDiscordStarted=$(hyprctl clients -j | jq 'map(select(.initialTitle | test("- Discord"))) | length')
    while [[ $isDiscordStarted == 0 ]]
    do
      sleep 0.5
      echo "=================================================================================================="
      echo "Waiting for Discord to start..."
      echo "=================================================================================================="
      isDiscordStarted=$(hyprctl clients -j | jq 'map(select(.initialTitle | test("- Discord"))) | length')
    done
    sleep 0.5
    isDiscordStarted=$(hyprctl clients -j | jq 'map(select(.initialTitle | test("- Discord"))) | length')
    while [[ $isDiscordStarted == 0 ]]
    do
      sleep 0.5
      echo "=================================================================================================="
      echo "Waiting for Discord to start..."
      echo "=================================================================================================="
      isDiscordStarted=$(hyprctl clients -j | jq 'map(select(.initialTitle | test("- Discord"))) | length')
    done
    discordAddress=$(hyprctl clients -j | jq 'map(select(.initialTitle | test("- Discord"))) | .[0].address')
    echo "=================================================================================================="
    echo "Found discord at: $discordAddress"
    echo "=================================================================================================="
#    hyprctl dispatch focuswindow "address:$discordAddress"
#    sleep 0.1
#    hyprctl dispatch moveoutofgroup
#    sleep 0.1
    hyprctl dispatch workspace $activews
fi
