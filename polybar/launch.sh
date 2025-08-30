#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Check if monitors are mirrored
PRIMARY=$(xrandr --query | grep " connected primary" | cut -d' ' -f1)
MONITORS=($(xrandr --query | grep " connected" | cut -d' ' -f1))

# Get monitor positions
declare -A POSITIONS
for monitor in "${MONITORS[@]}"; do
    POS=$(xrandr --query | grep "^$monitor connected" | grep -oE '[0-9]+x[0-9]+\+[0-9]+\+[0-9]+' | cut -d'+' -f2,3)
    POSITIONS[$monitor]=$POS
done

# Check if all monitors have the same position (mirrored)
MIRRORED=true
FIRST_POS="${POSITIONS[${MONITORS[0]}]}"
for monitor in "${MONITORS[@]}"; do
    if [ "${POSITIONS[$monitor]}" != "$FIRST_POS" ]; then
        MIRRORED=false
        break
    fi
done

if [ "$MIRRORED" = true ]; then
    echo "Monitors are mirrored - launching single polybar"
    # Launch polybar on primary monitor only
    if [ -n "$PRIMARY" ]; then
        MONITOR=$PRIMARY polybar --reload example &
    else
        MONITOR=${MONITORS[0]} polybar --reload example &
    fi
else
    echo "Multiple monitors detected - launching polybar on each"
    # Launch polybar on each monitor
    for m in "${MONITORS[@]}"; do
        MONITOR=$m polybar --reload example &
    done
fi

echo "Polybar launched..."