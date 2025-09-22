#!/usr/bin/env bash

DMENU_CMD="rofi -dmenu -i -p"

sink_exists() {
  pactl list short sinks | awk '{print $2}' | grep -Fxq "$1"
}

set_sink() {
  local sink_name="$1"
  local notify_color="$2"
  local notify_msg="$3"

  if ! sink_exists "$sink_name"; then
    notify-send -u critical -h string:bgcolor:"#bf616a" "Audio sink not found: $sink_name"
    echo "Sink not found: $sink_name" >&2
    return 1
  fi

  echo "Setting default sink to $sink_name"
  if ! pactl set-default-sink "$sink_name"; then
    notify-send -u critical -h string:bgcolor:"#bf616a" "Failed to set default sink: $sink_name"
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
  set_sink "alsa_output.usb-Logitech_PRO_X_Wireless_Gaming_Headset-00.analog-stereo" "#a3be8c" "Audio switched to Logitech Pro headphones!"
}

bluetooth() {
  declare -A bt_devices=(
    ["bluez_output.80_C3_BA_70_64_6B.1"]="Momentum 4"
    ["bluez_output.84_AC_60_89_83_7C.1"]="Wavell pro"
  )

  choices=$(printf "%s\n" "${bt_devices[@]}")

  choice=$(echo "$choices" | $DMENU_CMD "Choose bluetooth device:")

  if [[ -n "$choice" ]]; then
    for sink in "${!bt_devices[@]}"; do
      if [[ "${bt_devices[$sink]}" == "$choice" ]]; then
        set_sink "$sink" "#88c0d0" "Audio switched to bluetooth device: $choice"
        exit 0
      fi
    done
  else
    notify-send "No bluetooth device selected."
  fi
}

choosespeakers() {
  choice=$(printf "Logitech Pro\nBluetooth" | $DMENU_CMD "Choose output")

  case "$choice" in
    "Logitech Pro") headphones ;;
    Bluetooth) bluetooth ;;
    *) notify-send "No valid selection made." ;;
  esac
}

choosespeakers
