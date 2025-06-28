#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script handles NixOS configuration switching with pre/post flight checks
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/rh-helpers.sh"

function usage() {
    echo "Usage: $0 <host>"
    echo "Build and switch to NixOS configuration for the specified host"
    exit 1
}

function pre_flight_checks() {
    local host="$1"
    print_pending "Pre-flight checks for $host"

    if nix flake check "$FLAKE_PATH" 2>/dev/null; then
        print_success "  Flake validation passed"
    else
        print_partial "  Flake validation failed [continuing anyway]"
    fi
}

function source_user_vars() {
    print_pending "Sourcing User Vars"
    if [ -f "/etc/profiles/per-user/${USER}/etc/profile.d/hm-session-vars.sh" ]; then
        source "/etc/profiles/per-user/${USER}/etc/profile.d/hm-session-vars.sh"
    fi
    print_success "Sourced User Vars"
}

function reload_services() {
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

function main() {
    if [ $# -ne 1 ]; then
        usage
    fi

    local host="$1"

    # Pre-flight checks
    pre_flight_checks "$host"

    # Build and switch
    print_pending "Building and switching configuration..."
    sudo nixos-rebuild switch --flake "${FLAKE_PATH}#${host}"

    # Post-build tasks
    print_pending "Running post-build tasks..."
    source_user_vars
    "${MODULES_PATH}/cache/build-caches.sh"
    python3 "${MODULES_PATH}/cache/build-icons-cache.py"
    reload_services

    print_success "System rebuild complete"
}

main "$@"
