### set terminal defaults
#xrdb -load ~/.Xresources
### set cursor  
#xsetroot -cursor_name left_ptr
### start pulseaudio # don't use pulse anymore. just alsa.
##pulseaudio --start
### call script that swaps capslock and escape
#xmodmap ~/scripts/speedswapper
### set background image
### start mpd as me
##mpd /home/coop/.mpd/mpd.conf
### start xmonad
#xmonad

setxkbmap -option caps:escape # set capslock to be a second escape
xsetroot -cursor_name left_ptr
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 5 --transparent true --alpha 0 --tint 0x191970 --height 12 &  
nm-applet &
sh ~/.fehbg &
xflux -z 93117
exec dbus-launch xmonad 
