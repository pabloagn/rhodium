#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script rolls back to previous generation
#

# --- Imports ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_DIR="$(dirname "$SCRIPT_DIR")/common"
source "${COMMON_DIR}/helpers.sh"

# --- Functions ---
function main() {
    print_partial "Rolling back to previous generation..."
    sudo nixos-rebuild switch --rollback
    print_success "Rollback complete"
}

main "$@"
