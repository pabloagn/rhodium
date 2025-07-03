#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script handles NixOS configuration switching with pre/post flight checks
#

# --- Imports ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_DIR="$(dirname "$SCRIPT_DIR")/common"
source "${COMMON_DIR}/helpers.sh"

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
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then
        usage
    fi
    
    local host="$1"
    local mode="${2:-}"
    local is_fast_mode=false
    
    # Check if fast mode is requested
    if [ "$mode" = "fast" ]; then
        is_fast_mode=true
        print_pending "Fast mode enabled - skipping pre/post checks"
    fi
    
    # Pre-flight checks (skip in fast mode)
    if [ "$is_fast_mode" = false ]; then
        pre_flight_checks "$host"
    fi
    
    # Build and switch (always performed)
    print_pending "Building and switching configuration..."
    sudo nixos-rebuild switch --flake "${FLAKE_PATH}#${host}"
    
    # Post-build tasks (skip in fast mode)
    if [ "$is_fast_mode" = false ]; then
        print_pending "Running post-build tasks..."
        source_user_vars
        "${COMMON_DIR}/build-cache.sh" -e
        python3 "${COMMON_DIR}/build-icons-cache.py"
        reload_services
        print_success "System rebuild complete"
    else
        print_success "Fast rebuild complete"
    fi
}

main "$@"
