#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then

    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# # start some nice programs

# if [ -d /etc/X11/xinit/xinitrc.d ] ; then
#  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#   [ -x "$f" ] && . "$f"
#  done
#  unset f
# fi

# start status bar
slstatus &

# start the audio services 
pulseaudio --start &

# set background images by cating a file to terminal
eval `cat ~/.setbg` &

# set windows display
xrandr --output DP-0 --primary --left-of HDMI-0 &

lxpolkit &

# start usb dbus to load input devices into the session
exec dbus-run-session dwm

# start the dwm window manager
exec dwm
