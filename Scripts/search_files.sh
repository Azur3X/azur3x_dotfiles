#!/usr/bin/env bash

# Function to get KDE colors
get_kde_colors() {
  local config_file="$HOME/.config/kdeglobals"
  
  if [[ -f "$config_file" ]]; then
    bg=$(kreadconfig5 --file kdeglobals --group Colors:Window --key BackgroundNormal)
    fg=$(kreadconfig5 --file kdeglobals --group Colors:Window --key ForegroundNormal)
    selected_bg=$(kreadconfig5 --file kdeglobals --group Colors:Selection --key BackgroundNormal)
    selected_fg=$(kreadconfig5 --file kdeglobals --group Colors:Selection --key ForegroundNormal)
    
    # Convert KDE's "r,g,b" format to hex
    bg_hex=$(echo "$bg" | awk -F',' '{printf "#%02x%02x%02x", $1, $2, $3}')
    fg_hex=$(echo "$fg" | awk -F',' '{printf "#%02x%02x%02x", $1, $2, $3}')
    sel_bg_hex=$(echo "$selected_bg" | awk -F',' '{printf "#%02x%02x%02x", $1, $2, $3}')
    sel_fg_hex=$(echo "$selected_fg" | awk -F',' '{printf "#%02x%02x%02x", $1, $2, $3}')
  else
    # Fallback colors
    bg_hex="#1e1e1e"
    fg_hex="#ffffff"
    sel_bg_hex="#5294e2"
    sel_fg_hex="#ffffff"
  fi
}

# Get KDE colors
get_kde_colors

# Configure rofi with KDE colors
ROFI_THEME=(
  -theme-str "window {background-color: $bg_hex; border: 0px;}"
  -theme-str "listview {background-color: $bg_hex;}"
  -theme-str "element {text-color: $fg_hex; background-color: $bg_hex;}"
  -theme-str "element selected {text-color: $sel_fg_hex; background-color: $sel_bg_hex;}"
  -theme-str "inputbar {text-color: $fg_hex; background-color: $bg_hex;}"
)

folder="$HOME"
TERMINAL="konsole" # Change to alacritty if you want
EDITOR="nano"

selected=$(fd --type f --hidden --exclude ".local" --exclude "Downloads" . "$folder" | rofi -dmenu -i "${ROFI_THEME[@]}" -p "Search files")

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
