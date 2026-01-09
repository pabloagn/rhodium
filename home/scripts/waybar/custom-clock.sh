#!/usr/bin/env bash

entries=(
    "AMS|Europe/Amsterdam"
    "BCN|Europe/Madrid"
    "BRL|Europe/Berlin"
    "GNV|Europe/Zurich"
    "HKG|Asia/Hong_Kong"
    "JPN|Asia/Tokyo"
    "LAX|America/Los_Angeles"
    "LND|Europe/London"
    "MCH|Europe/Berlin"
    "MXC|America/Mexico_City"
    "NYC|America/New_York"
    "ZRC|Europe/Zurich"
)

state_file="/tmp/waybar-clock.state"
default_tz=$(readlink -f /etc/localtime | sed 's|.*/zoneinfo/||')

[[ -f "$state_file" ]] || echo 0 >"$state_file"
index=$(<"$state_file")
((index < 0 || index >= ${#entries[@]})) && index=0

entry="${entries[$index]}"
code="${entry%%|*}"
tz="${entry##*|}"

if [[ "$tz" == "$default_tz" ]]; then
    class="local"
else
    class="nonlocal"
fi

# Get time and offset
time=$(TZ="$tz" date '+%H.%M.%S')
offset=$(TZ="$tz" date +%z)   # e.g. +0200
offset_fmt="GMT${offset:0:3}" # e.g. GMT+2

# Output: HH.MM.SS CODE/GMT+X
text="$time $code/$offset_fmt"

jq -nc --arg text "$text" --arg tooltip "$tz" --arg class "$class" \
    '{text:$text, tooltip:$tooltip, class:$class}'
