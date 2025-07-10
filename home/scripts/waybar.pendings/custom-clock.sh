#!/usr/bin/env bash

set -euo pipefail

tz_file="${XDG_BIN_HOME:-$HOME/.local/bin}/rh-waybar/clock/timezones.json"
[[ -r "$tz_file" ]] || {
    echo "timezones.json missing" >&2
    exit 1
}

# alphabetic list of acronyms
mapfile -t CODES < <(jq -r 'keys_unsorted[]' "$tz_file" | sort)

state_file="/tmp/waybar-clock.state"
[[ -f "$state_file" ]] || echo 0 >"$state_file"
index=$(<"$state_file")
((index < 0 || index >= ${#CODES[@]})) && index=0

code="${CODES[$index]}"
tz=$(jq -r --arg code "$code" '.[$code]' "$tz_file")

default_tz=$(readlink -f /etc/localtime | sed 's|.*/zoneinfo/||')
class=$([[ "$tz" == "$default_tz" ]] && echo "local" || echo "nonlocal")

time=$(TZ="$tz" date '+%H.%M.%S')
offset=$(TZ="$tz" date +%z)   # +0100
offset_fmt="GMT${offset:0:3}" # GMT+1
text="$time $code/$offset_fmt"

jq -nc --arg text "$text" \
    --arg tooltip "$tz" \
    --arg class "$class" \
    '{text:$text, tooltip:$tooltip, class:$class}'
