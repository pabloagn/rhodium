#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script shows flake metadata
#

# --- Imports ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_DIR="$(dirname "$SCRIPT_DIR")/common"
source "${COMMON_DIR}/helpers.sh"

# --- Functions ---
function main() {
    print_header "FLAKE INFORMATION"
    echo ""
    nix flake metadata "${FLAKE_PATH}"
}

main "$@"
