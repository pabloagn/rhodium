#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script handles NixOS build operations without switching
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-build"

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Functions ---
function usage() {
    echo "Usage: $0 <host> <mode>"
    echo "Build NixOS configuration for the specified host"
    echo ""
    echo "Arguments:"
    echo "  host    Target host configuration"
    echo "  mode    Build mode: build|boot|dry|dev"
    echo ""
    echo "Modes:"
    echo "  build   Build without switching [test build]"
    echo "  boot    Rebuild and boot into new generation"
    echo "  dry     Dry run - show what would be built"
    echo "  dev     Development rebuild with verbose output"
    exit 1
}

function main() {
    if [ $# -ne 2 ]; then
        usage
    fi

    local host="$1"
    local mode="$2"

    case "$mode" in
    "build")
        notify "$APP_TITLE" "$RECIPE:\n◌Building configuration for $host..."
        sudo nixos-rebuild build --flake "${FLAKE_PATH}#${host}"
        notify "$APP_TITLE" "$RECIPE:\n◌Build successful [not activated]"
        ;;
    "boot")
        notify "$APP_TITLE" "$RECIPE:\n◌Building boot configuration for $host..."
        sudo nixos-rebuild boot --flake "${FLAKE_PATH}#${host}"
        notify "$APP_TITLE" "$RECIPE:\n◌Will boot into new generation on next reboot"
        ;;
    "dry")
        notify "$APP_TITLE" "$RECIPE:\n◌Dry run for $host..."
        sudo nixos-rebuild dry-build --flake "${FLAKE_PATH}#${host}"
        ;;
    "dev")
        notify "$APP_TITLE" "$RECIPE:\n◌Development build with trace output for $host"
        sudo nixos-rebuild switch --flake "${FLAKE_PATH}#${host}" --show-trace -L
        ;;
    *)
        notify "$APP_TITLE" "$RECIPE:\n◌ERROR: Invalid mode: $mode"
        usage
        ;;
    esac
}

main "$@"
