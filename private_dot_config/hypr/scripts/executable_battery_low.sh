#!/bin/sh
set -ex

while true; do
  # Get info for all batteries
  while IFS= read -r line; do
    # Check if this battery is discharging
    if echo "$line" | grep -q "Discharging"; then
      # Extract percentage from this line
      battery_level=$(echo "$line" | grep -P -o '[0-9]+(?=%)')
      battery_level=$((battery_level - 1))

      if [ "$battery_level" -le 5 ]; then
        notify-send -u critical "battery very low" "(${battery_level}%!)"
      elif [ "$battery_level" -le 10 ]; then
        notify-send -u normal "battery low" "(${battery_level}%)"
      fi
    fi
  done <<< "$(acpi -b)"

  sleep 60
done
