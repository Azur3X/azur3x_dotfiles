#!/bin/bash
export DISPLAY=:1
export XDG_RUNTIME_DIR=/run/user/1000

# Get current hour (24h format)
hour=$(date +%H)

# Toggle ON if between 22 and 8
if [ "$hour" -ge 22 ] || [ "$hour" -lt 9 ]; then
    ~/.config/hypr/scripts/hyprshade.sh
else
    # Only toggle off if currently on
    if [ ! -z "$(hyprshade current)" ]; then
        ~/.config/hypr/scripts/hyprshade.sh
    fi
fi
