#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
userkeymap=$XDG_CONFIG_HOME/sxhkd/sxhkd

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

# start some nice programs

if [ -r $userkeymap ]; then
    pgrep -x sxhkd > /dev/null || sxhkd &
fi


if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#feh --bg-center $HOME/Pictures/Backgrounds/japan1.jpg
wal -R
setxkbmap gb &
#$HOME/.screenlayout/main_display.sh
xsetroot -cursor_name left_ptr
picom -f &
# exec bspwm
while :; do
    ssh-agent dwm 
done

$HOME/.local/bin/autodisplay
dwmblocks &

setxkbmap -option caps:ctrl

