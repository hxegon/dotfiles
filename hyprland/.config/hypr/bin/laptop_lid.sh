#!/usr/bin/env zsh

# if external monitor is connected
if [[ $(hyprctl monitors) =~ "\sDP-[0-9+]" ]]; then
    # then close/open lid behavior only turns off display
    if [[ $1 == "open" ]]; then
        # FIXME: Doesn't work unless the external monitor is registered
        # as DP-1. Need to capture the actual ID of the monitor
        # in the regex.
        hyprctl keyword monitor "eDP-1,22556x1504,0x0,1"
        MSG="Enabling laptop monitor"
    elif [[ $1 == "close" ]]; then
        hyprctl keyword monitor "eDP-1,disable"
        MSG="Disabling laptop monitor"
    else
        MSG="Invalid argument to clamshell_mode '$1'"
    fi
    notify-send "$MSG"

# No external monitor AND lid is closing
elif [[ $1 == "close" ]]; then
    # Lock screen and suspend
    swaylock --image ~/Pictures/Wallpapers/cumulonimbus.webp --clock & systemctl suspend
fi
