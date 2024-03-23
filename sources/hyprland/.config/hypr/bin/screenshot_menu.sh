#!/usr/bin/env zsh

SS_OPTIONS="selection
screen
all screens"

SS_PATH="$HOME/Pictures/Screenshots/$(date).png"

case "$(echo "$SS_OPTIONS" | wofi --show dmenu)" in
  'selection')
    SS_OUT="$(grimblast save area $SS_PATH)"
    notify-send "Took a screenshot"
    ;;
  'screen')
    SS_OUT="$(grimblast save output $SS_PATH)"
    notify-send "Took a screenshot"
    ;;
  'all screens')
    SS_OUT="$(grimblast save screen $SS_PATH)"
    notify-send "Took a screenshot"
    ;;
esac

[[ "$SS_OUT" ]] && lximage-qt "$SS_OUT"

