#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script formats Nix files
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-fmt"

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Functions ---
function main() {
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Formatting Nix files..."
    count=$(find "${FLAKE_PATH}" -name "*.nix" -type f | wc -l)
    find "${FLAKE_PATH}" -name "*.nix" -type f -exec nixfmt {} +
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Formatted $count files"
}

main "$@"
