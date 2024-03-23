#!/bin/bash
# If you are running this on Ubuntu through the standard display manager
# ln <this file> ~/.xsessionrc

## set terminal defaults
#xrdb -load ~/.Xresources
# TODO: Conditionally start with pulseaudio --check condition
pulseaudio --start
#mpd /home/coop/.mpd/mpd.conf

# xsetroot -cursor_name left_ptr
# setxkbmap dvorak
# setxkbmap en_US # enforces qwerty, dvorak is implemented in keyboard
setxkbmap -option caps:escape # set capslock to be a second escape
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 4 --transparent true --tint 0x191970 --height 13 &  
if [ -x /usr/bin/nm-applet ] ; then
  nm-applet &
fi
sh ~/.fehbg &
# xflux -z 93117 &
# exec dbus-launch xmonad # handled by display manager
