#!/bin/bash

if [ $# -eq 1 ]; then
	[ "$1" = "up" ] && pactl set-source-volume @DEFAULT_SOURCE@ +5%
	[ "$1" = "down" ] && pactl set-source-volume @DEFAULT_SOURCE@ -5%
	[ "$1" = "toggle" ] && pactl set-source-mute @DEFAULT_SOURCE@ toggle
fi

info=$(amixer -D pulse get Capture)
percentage=$(echo "$info" | grep -E "Front Left:|Mono:" | grep -Eo '\[([0-9]+)%\]' | tr -d '[]')
stat=$(echo "$info" | grep -E "Front Left:|Mono:" | grep -Eo '\[(on|off)\]' | tr -d '[]')

if [[ $stat = "on" ]]; then
	echo " $percentage"
else
	echo " $percentage"
fi

exit 1
