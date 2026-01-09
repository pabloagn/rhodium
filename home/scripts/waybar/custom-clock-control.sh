#!/usr/bin/env bash

entries=(
  "AMS|Europe/Amsterdam"
  "LND|Europe/London"
  "NYC|America/New_York"
  "MXC|America/Mexico_City"
  "BCN|Europe/Madrid"
  "LAX|America/Los_Angeles"
  "HKG|Asia/Hong_Kong"
  "JPN|Asia/Tokyo"
  "BRL|Europe/Berlin"
  "MCH|Europe/Berlin"
  "ZRC|Europe/Zurich"
  "GNV|Europe/Zurich"
)

state_file="/tmp/waybar-clock.state"
[[ -f "$state_file" ]] || echo 0 > "$state_file"
index=$(<"$state_file")

case "$1" in
  up)
    index=$(( (index + 1) % ${#entries[@]} ))
    ;;
  down)
    index=$(( (index - 1 + ${#entries[@]}) % ${#entries[@]} ))
    ;;
esac

echo "$index" > "$state_file"

