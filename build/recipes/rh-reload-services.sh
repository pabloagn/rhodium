#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script reloads user services
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-reload-services"

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Functions ---
function main() {
    notify "$APP_TITLE" "$RECIPE:\n◌Reloading User Services..."
    systemctl --user daemon-reload
    if command -v niri >/dev/null 2>&1; then niri msg action do-screen-transition --delay-ms 800 2>/dev/null || true; fi
    for service in rh-swaybg rh-waybar; do systemctl --user restart "$service.service" || true; done
    makoctl reload
    notify "$APP_TITLE" "$RECIPE:\n◌Reloaded User Services"
}

main "$@"
