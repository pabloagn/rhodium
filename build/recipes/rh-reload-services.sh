#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script reloads user services
#

# --- Imports ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_DIR="$(dirname "$SCRIPT_DIR")/common"
source "${COMMON_DIR}/helpers.sh"

# --- Functions ---
function main() {
    print_pending "Reloading User Services"
    systemctl --user daemon-reload
    
    # Trigger niri screen transition if available
    if command -v niri >/dev/null 2>&1; then
        niri msg action do-screen-transition --delay-ms 800 2>/dev/null || true
    fi
    
    # Restart Rhodium services
    for service in rh-swaybg rh-waybar; do
        systemctl --user restart "$service.service" || true
    done
    
    print_success "Reloaded User Services"
}

main "$@"
