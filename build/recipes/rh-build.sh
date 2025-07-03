#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script handles NixOS build operations without switching
#

# --- Imports ---
SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
COMMON_DIR="$(dirname "$SCRIPT_DIR")/common"
source "${COMMON_DIR}/helpers.sh"

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
        print_pending "Building configuration for $host..."
        sudo nixos-rebuild build --flake "${FLAKE_PATH}#${host}"
        print_success "Build successful [not activated]"
        ;;
    "boot")
        print_pending "Building boot configuration for $host..."
        sudo nixos-rebuild boot --flake "${FLAKE_PATH}#${host}"
        print_success "Will boot into new generation on next reboot"
        ;;
    "dry")
        print_pending "Dry run for $host..."
        sudo nixos-rebuild dry-build --flake "${FLAKE_PATH}#${host}"
        ;;
    "dev")
        print_partial "Development build with trace output for $host"
        sudo nixos-rebuild switch --flake "${FLAKE_PATH}#${host}" --show-trace -L
        ;;
    *)
        print_error "Invalid mode: $mode"
        usage
        ;;
    esac
}

main "$@"
