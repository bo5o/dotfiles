#!/usr/bin/bash

#Feed this script either:
#	"l" for laptop screen only,
#	"v" for vga screen only,
#	or "d" for dual vga/laptop.

laptop() { xrandr --output LVDS-1 --auto --output VGA-1 --off ;}
vga() { xrandr --output VGA-1 --auto --output LVDS-1 --off ;}
dual() { xrandr --output LVDS-1 --auto --output VGA-1 --auto --right-of LVDS-1 ;}

param() {
case $1 in
	d) dual ;;
	v) vga ;;
	l) laptop ;;
esac ;}
param $1
sleep 2
source ~/.config/polybar/launch.sh
