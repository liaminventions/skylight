#!/bin/bash

# File path
VOL_FILE=~/vol

# Constants
INCREMENT=13107
MAX_VOLUME=65536

# Read current volume (default to 0 if file does not exist or is empty)
if [ -f "$VOL_FILE" ]; then
    CURRENT_VOL=$(cat "$VOL_FILE")
else
    CURRENT_VOL=0
fi

# Ensure it's a valid number
if ! [[ "$CURRENT_VOL" =~ ^[0-9]+$ ]]; then
    echo "0" > "$VOL_FILE"
    CURRENT_VOL=0
fi

# Add increment
NEW_VOL=$((CURRENT_VOL + INCREMENT))

# Wrap around if exceeding MAX_VOLUME
if [ "$NEW_VOL" -gt "$MAX_VOLUME" ]; then
    NEW_VOL=$INCREMENT
fi

# Save the new volume
echo "$NEW_VOL" > "$VOL_FILE"

# Optional: output the new volume
echo "Volume set to: $NEW_VOL"

~/play vol &
