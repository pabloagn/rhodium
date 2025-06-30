#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script formats Nix files
#

# --- Imports ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_DIR="$(dirname "$SCRIPT_DIR")/common"
source "${COMMON_DIR}/helpers.sh"

# --- Functions ---
function main() {
    print_pending "Formatting Nix files..."
    count=$(find "${FLAKE_PATH}" -name "*.nix" -type f | wc -l)
    find "${FLAKE_PATH}" -name "*.nix" -type f -exec nixfmt {} +
    print_success "Formatted $count files"
}

main "$@"
