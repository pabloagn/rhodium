#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script shows system generation details
#

# --- Imports ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_DIR="$(dirname "$SCRIPT_DIR")/common"
source "${COMMON_DIR}/helpers.sh"

# --- Functions ---
function main() {
    print_header "SYSTEM GENERATIONS"
    echo ""
    sudo nix-env --list-generations -p /nix/var/nix/profiles/system | tail -10
}

main "$@"
