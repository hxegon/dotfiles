## set terminal defaults
#xrdb -load ~/.Xresources
## start pulseaudio # don't use pulse anymore. just alsa.
#pulseaudio --start
## call script that swaps capslock and escape
## start mpd as me
#mpd /home/coop/.mpd/mpd.conf

xsetroot -cursor_name left_ptr
setxkbmap dvorak
setxkbmap -option caps:escape # set capslock to be a second escape
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 4 --transparent true --tint 0x191970 --height 13 &  
if [ -x /usr/bin/nm-applet ] ; then
  nm-applet &
fi
sh ~/.fehbg &
xflux -z 93117 &
exec dbus-launch xmonad 
