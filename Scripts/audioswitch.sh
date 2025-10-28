#!/usr/bin/env bash

# Function to get KDE colors
get_kde_colors() {
  local config_file="$HOME/.config/kdeglobals"
  
  if [[ -f "$config_file" ]]; then
    bg=$(kreadconfig5 --file kdeglobals --group Colors:Window --key BackgroundNormal)
    fg=$(kreadconfig5 --file kdeglobals --group Colors:Window --key ForegroundNormal)
    selected_bg=$(kreadconfig5 --file kdeglobals --group Colors:Selection --key BackgroundNormal)
    selected_fg=$(kreadconfig5 --file kdeglobals --group Colors:Selection --key ForegroundNormal)
    positive=$(kreadconfig5 --file kdeglobals --group Colors:View --key ForegroundPositive)
    negative=$(kreadconfig5 --file kdeglobals --group Colors:View --key ForegroundNegative)
    
    # Convert KDE's "r,g,b" format to hex
    bg_hex=$(echo "$bg" | awk -F',' '{printf "#%02x%02x%02x", $1, $2, $3}')
    fg_hex=$(echo "$fg" | awk -F',' '{printf "#%02x%02x%02x", $1, $2, $3}')
    sel_bg_hex=$(echo "$selected_bg" | awk -F',' '{printf "#%02x%02x%02x", $1, $2, $3}')
    sel_fg_hex=$(echo "$selected_fg" | awk -F',' '{printf "#%02x%02x%02x", $1, $2, $3}')
    pos_hex=$(echo "$positive" | awk -F',' '{printf "#%02x%02x%02x", $1, $2, $3}')
    neg_hex=$(echo "$negative" | awk -F',' '{printf "#%02x%02x%02x", $1, $2, $3}')
  else
    # Fallback colors
    bg_hex="#1e1e1e"
    fg_hex="#ffffff"
    sel_bg_hex="#5294e2"
    sel_fg_hex="#ffffff"
    pos_hex="#27ae60"
    neg_hex="#da4453"
  fi
}

# Get KDE colors
get_kde_colors

# Configure rofi with KDE colors
DMENU_CMD="rofi -dmenu -i -p"
DMENU_THEME=(
  -theme-str "window {background-color: $bg_hex; border: 0px;}"
  -theme-str "listview {background-color: $bg_hex;}"
  -theme-str "element {text-color: $fg_hex; background-color: $bg_hex;}"
  -theme-str "element selected {text-color: $sel_fg_hex; background-color: $sel_bg_hex;}"
  -theme-str "inputbar {text-color: $fg_hex; background-color: $bg_hex;}"
)

sink_exists() {
  pactl list short sinks | awk '{print $2}' | grep -Fxq "$1"
}

set_sink() {
  local sink_name="$1"
  local notify_color="$2"
  local notify_msg="$3"
  
  if ! sink_exists "$sink_name"; then
    notify-send -u critical -h string:bgcolor:"$neg_hex" "Audio sink not found: $sink_name"
    echo "Sink not found: $sink_name" >&2
    return 1
  fi
  
  echo "Setting default sink to $sink_name"
  if ! pactl set-default-sink "$sink_name"; then
    notify-send -u critical -h string:bgcolor:"$neg_hex" "Failed to set default sink: $sink_name"
    echo "Failed to set default sink: $sink_name" >&2
    return 1
  fi
  
  echo "Moving sink inputs to $sink_name"
  local moved=0
  while IFS= read -r input_id; do
    echo "Moving sink input $input_id to $sink_name"
    if pactl move-sink-input "$input_id" "$sink_name"; then
      ((moved++))
    fi
  done < <(pactl list sink-inputs short | cut -f1)
  
  echo "Moved $moved sink input(s) to $sink_name"
  notify-send -h string:bgcolor:"$notify_color" "$notify_msg"
  return 0
}

headphones() {
  set_sink "alsa_output.usb-Logitech_PRO_X_Wireless_Gaming_Headset-00.analog-stereo" "$pos_hex" "Audio switched to Logitech Pro headphones!"
}

bluetooth() {
  declare -A bt_devices=(
    ["bluez_output.80_C3_BA_70_64_6B.1"]="Momentum 4"
    ["bluez_output.84_AC_60_89_83_7C.1"]="Wavell pro"
  )
  
  choices=$(printf "%s\n" "${bt_devices[@]}")
  choice=$(echo "$choices" | $DMENU_CMD "${DMENU_THEME[@]}" "Choose bluetooth device:")
  
  if [[ -n "$choice" ]]; then
    for sink in "${!bt_devices[@]}"; do
      if [[ "${bt_devices[$sink]}" == "$choice" ]]; then
        set_sink "$sink" "$sel_bg_hex" "Audio switched to bluetooth device: $choice"
        exit 0
      fi
    done
  else
    notify-send "No bluetooth device selected."
  fi
}

choosespeakers() {
  choice=$(printf "Logitech Pro\nBluetooth" | $DMENU_CMD "${DMENU_THEME[@]}" "Choose output")
  
  case "$choice" in
    "Logitech Pro") headphones ;;
    Bluetooth) bluetooth ;;
    *) notify-send "No valid selection made." ;;
  esac
}

choosespeakers
