#!/usr/bin/env bash

shopt -s nullglob globstar

typeit=0
if [[ $1 == "--type" ]]; then
  typeit=1
  shift
fi

if [[ -n $WAYLAND_DISPLAY ]]; then
  dmenu=(rofi -dmenu -i -p "Choose password")
  xdotool="ydotool type --file -"
elif [[ -n $DISPLAY ]]; then
  dmenu=(rofi -dmenu -i -p "Choose password")
  xdotool="xdotool type --clearmodifiers --file -"
else
  echo "Error: No Wayland or X11 display detected" >&2
  exit 1
fi

prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files=( "$prefix"/**/*.gpg )

# Strip prefix directory and .gpg extension
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )

# Show password entries menu, get selection
password=$(printf '%s\n' "${password_files[@]}" | "${dmenu[@]}" "$@")

[[ -n $password ]] || exit

if [[ $typeit -eq 0 ]]; then
  # Copy password to clipboard quietly
  pass show -c "$password" 2>/dev/null
else
  # Type password inline via xdotool or ydotool
  pass show "$password" | { IFS= read -r pass; printf %s "$pass"; } | $xdotool
fi
