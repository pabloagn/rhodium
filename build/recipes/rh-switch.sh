#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script handles NixOS configuration switching with pre/post flight checks
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-switch"

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Functions ---
function usage() {
    echo "Usage: $0 <host> [fast]"
    echo "Build and switch to NixOS configuration for the specified host"
    echo ""
    echo "Arguments:"
    echo "  host    Target host configuration"
    echo "  fast    Optional: Skip pre-flight checks and post-build tasks"
    exit 1
}

function pre_flight_checks() {
    local host="$1"
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Pre-flight checks for $host..."
    if nix flake check "$FLAKE_PATH" 2>/dev/null; then
        notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Flake validation passed"
    else
        notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Warning: Flake validation failed [continuing anyway]"
    fi
}

function source_user_vars() {
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Sourcing User Vars..."
    if [ -f "/etc/profiles/per-user/${USER}/etc/profile.d/hm-session-vars.sh" ]; then
        source "/etc/profiles/per-user/${USER}/etc/profile.d/hm-session-vars.sh"
    fi
}

function reload_services() {
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Reloading User Services..."
    systemctl --user daemon-reload
    if command -v niri >/dev/null 2>&1; then niri msg action do-screen-transition --delay-ms 800 2>/dev/null || true; fi
    for service in rh-swaybg rh-eww; do systemctl --user restart "$service.service" || true; done
    makoctl reload
}

function main() {
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then usage; fi

    local host="$1"
    local mode="${2:-}"
    local is_fast_mode=false
    if [ "$mode" = "fast" ]; then
        is_fast_mode=true
        notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Fast mode enabled - skipping pre/post checks"
    fi

    if [ "$is_fast_mode" = false ]; then pre_flight_checks "$host"; fi

    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Building and switching configuration..."
    sudo nixos-rebuild switch --flake "${FLAKE_PATH}#${host}"

    if [ "$is_fast_mode" = false ]; then
        notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Running post-build tasks..."
        source_user_vars
        "${COMMON_DIR}/build-cache.sh" -e
        python3 "${COMMON_DIR}/build-icons-cache.py"
        reload_services
        notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} System rebuild complete"
    else
        notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Fast rebuild complete"
    fi
}

main "$@"
