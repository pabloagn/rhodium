#!/usr/bin/env bash

set -euo pipefail

tz_file="${XDG_BIN_HOME:-$HOME/.local/bin}/waybar/modules/custom-clock/timezones.json"
num_entries=$(jq 'length' "$tz_file")

state_file="/tmp/waybar-clock.state"
[[ -f "$state_file" ]] || echo 0 >"$state_file"
index=$(<"$state_file")

case "${1:-}" in
  up)   index=$(((index + 1) %  num_entries));;
  down) index=$(((index - 1 + num_entries) % num_entries));;
  *)    echo "usage: $0 {up|down}" >&2; exit 2;;
esac

echo "$index" >"$state_file"

