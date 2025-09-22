#!/usr/bin/env bash

folder="$HOME/Notes/"
mkdir -p "$folder"

TERMINAL="alacritty"
EDITOR="nvim"

newnote() {
  name=$(rofi -dmenu -p "Enter a name" -lines 1)
  # Trim whitespace
  name=$(echo "$name" | xargs)

  # If empty input, exit without opening
  if [[ -z "$name" ]]; then
    exit 0
  fi

  setsid "$TERMINAL" -e "$EDITOR" "$folder$name.md" >/dev/null 2>&1
}

selected() {
  choice=$( (
    echo "New"
    ls -t1 "$folder"
  ) | rofi -dmenu -i -p "Choose note or create new" -lines 5)
  case $choice in
  New) newnote ;;
  *.md) setsid "$TERMINAL" -e "$EDITOR" "$folder$choice" >/dev/null 2>&1 ;;
  *) exit ;;
  esac
}

selected
