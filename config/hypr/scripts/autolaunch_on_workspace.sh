#! /bin/sh

hyprctl dispatch exec "discord --enable-features=UseOzonePlatform"
/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=slack --file-forwarding com.slack.Slack @@u %U @@

#hyprctl keyword windowrule "workspace 8 silent,caprine" && hyprctl dispatch exec "caprine"
#hyprctl keyword windowrule "workspace 7 silent,Electron" && hyprctl dispatch exec "discord"
#hyprctl keyword windowrule "workspace special silent,kitty" && hyprctl dispatch exec "kitty"

# sleep 15

# hyprctl keyword windowrule "unset,Electron"
# hyprctl keyword windowrule "unset,Caprine"
# hyprctl keyword windowrule "unset,kitty"
#hyprctl reload
