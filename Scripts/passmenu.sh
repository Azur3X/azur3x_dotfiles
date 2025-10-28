#!/usr/bin/env bash
shopt -s nullglob globstar

typeit=0
if [[ $1 == "--type" ]]; then
  typeit=1
  shift
fi

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
    # Fallback colors if kdeglobals not found
    bg_hex="#1e1e1e"
    fg_hex="#ffffff"
    sel_bg_hex="#5294e2"
    sel_fg_hex="#ffffff"
  fi
}

# Get KDE colors
get_kde_colors

if [[ -n $WAYLAND_DISPLAY ]]; then
  dmenu=(rofi -dmenu -i -p "🔐 Password" 
         -theme-str "window {background-color: $bg_hex; border: 0px;}" 
         -theme-str "listview {background-color: $bg_hex;}" 
         -theme-str "element {text-color: $fg_hex; background-color: $bg_hex;}"
         -theme-str "element selected {text-color: $sel_fg_hex; background-color: $sel_bg_hex;}"
         -theme-str "inputbar {text-color: $fg_hex; background-color: $bg_hex;}")
  xdotool="ydotool type --file -"
elif [[ -n $DISPLAY ]]; then
  dmenu=(rofi -dmenu -i -p "🔐 Password"
         -theme-str "window {background-color: $bg_hex; border: 0px;}" 
         -theme-str "listview {background-color: $bg_hex;}" 
         -theme-str "element {text-color: $fg_hex; background-color: $bg_hex;}"
         -theme-str "element selected {text-color: $sel_fg_hex; background-color: $sel_bg_hex;}"
         -theme-str "inputbar {text-color: $fg_hex; background-color: $bg_hex;}")
  xdotool="xdotool type --clearmodifiers --file -"
else
  echo "Error: No Wayland or X11 display detected" >&2
  exit 1
fi

prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

password=$(printf '%s\n' "${password_files[@]}" | "${dmenu[@]}" "$@")

[[ -n $password ]] || exit

if [[ $typeit -eq 0 ]]; then
  pass show -c "$password" 2>/dev/null
else
  pass show "$password" | { IFS= read -r pass; printf %s "$pass"; } | $xdotool
fi
