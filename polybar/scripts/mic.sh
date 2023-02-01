#!/bin/bash

if [ $# -eq 1 ]; then
	[ $1 = "up" ] && pactl set-source-volume @DEFAULT_SOURCE@ +5%
	[ $1 = "down" ] && pactl set-source-volume @DEFAULT_SOURCE@ -5%
	[ $1 = "toggle" ] && pactl set-source-mute @DEFAULT_SOURCE@ toggle
fi

info=$(amixer -D pulse get Capture | grep "Front Left:" | cut -d ' ' -f 7- | tr -d '[]')
percentage=$(echo $info | cut -d ' ' -f 1)
stat=$(echo $info | cut -d ' ' -f 2)

[[ $stat = "on" ]] && echo "$percentage" && exit

exit 1
