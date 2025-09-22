#!/bin/bash

folder="$HOME"
TERMINAL="konsole" # Change to alacritty if you want
EDITOR="nano"

selected=$(fd --type f --hidden --exclude ".local" --exclude "Downloads" . "$folder" | rofi -dmenu -i -p "Search files")

if [ -n "$selected" ]; then
  case "$selected" in
  # Shell scripts & configs open in nano inside terminal emulator
  *.sh | *.bash | *.zsh | *.conf)
    "$TERMINAL" -e "$EDITOR" "$selected" &
    ;;

  # Programming/config files in VS Code (GUI) with setsid to detach
  *.c | *.cpp | *.h | *.hpp | *.py | *.java | *.js | *.ts | *.rs | *.go | *.lua | *.html | *.css | *.json | *.yaml | *.yml | *.toml | *.xml)
    setsid code "$selected" &
    ;;

  # Markdown, text, logs open in nano inside terminal emulator
  *.md | *.txt | *.log)
    "$TERMINAL" -e "$EDITOR" "$selected" &
    ;;

  # Images open in GUI viewer detached
  *.png | *.jpg | *.jpeg | *.gif | *.bmp | *.webp | *.tiff)
    if command -v gwenview &>/dev/null; then
      setsid gwenview "$selected" &
    elif command -v feh &>/dev/null; then
      setsid feh "$selected" &
    else
      echo "No image viewer installed." >&2
    fi
    ;;

  # Videos open in mpv detached
  *.mp4 | *.mkv | *.webm | *.avi | *.mov | *.flv)
    setsid mpv "$selected" &
    ;;

  # PDFs open in Okular detached
  *.pdf)
    setsid okular "$selected" &
    ;;

  # Fallback: open in nano inside terminal emulator
  *)
    "$TERMINAL" -e "$EDITOR" "$selected" &
    ;;
  esac
else
  echo "No file selected."
fi
