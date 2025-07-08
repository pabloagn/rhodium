#!/usr/bin/env bash
# Battery info for Eww
set -euo pipefail

# Pick the first BAT* directory (BAT0, BAT1, …)
BAT_DIR="/sys/class/power_supply/$(ls /sys/class/power_supply | grep -m1 "^BAT")"

if [[ -d "$BAT_DIR" ]]; then
    CAPACITY=$(<"$BAT_DIR/capacity")
    STATUS=$(<"$BAT_DIR/status")
    if [[ "$STATUS" == "Charging" ]]; then
        CHARGING=true
    else
        CHARGING=false
    fi
    printf '{"percentage":%s,"status":"%s","charging":%s}\n' \
           "$CAPACITY" "$STATUS" "$CHARGING"
else
    # Desktop with no battery
    echo '{"percentage":100,"status":"Unknown","charging":false}'
fi

