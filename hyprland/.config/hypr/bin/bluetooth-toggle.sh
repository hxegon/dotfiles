#!/usr/bin/env bash

bluetooth_power="$(bluetoothctl show | grep 'Powered' | sed -E 's/.+(yes|no)$/\1/')"

case "$bluetooth_power" in
    yes)
        notify-send "Turning bluetooth off"
        bluetoothctl power off
        ;;
    no)
        notify-send "Turning bluetooth on"
        bluetoothctl power on
        ;;
    *)
        notify-send "error"
        echo "bluetooth_power: $bluetooth_power"
        ;;
esac
