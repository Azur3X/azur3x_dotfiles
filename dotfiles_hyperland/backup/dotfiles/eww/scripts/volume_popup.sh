#!/bin/bash

volume=$(pamixer --get-volume)
muted=$(pamixer --get-mute)

# Pick an icon path from your assets (use your own or edit paths)
if [ "$muted" = "true" ]; then
  icon="$HOME/.config/eww/assets/volume-muted.png"
else
  if [ "$volume" -lt 30 ]; then
    icon="$HOME/.config/eww/assets/volume-low.png"
  elif [ "$volume" -lt 70 ]; then
    icon="$HOME/.config/eww/assets/volume-medium.png"
  else
    icon="$HOME/.config/eww/assets/volume-high.png"
  fi
fi

# Send to Eww
eww update volume=$volume
eww update icon=\"$icon\"

# Reopen overlay window
eww close volume-window
sleep 0.05
eww open volume-window

# Auto-hide after 3s
sleep 3
eww close volume-window
