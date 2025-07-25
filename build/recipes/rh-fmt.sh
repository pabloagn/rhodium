#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Formats Nix files
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-fmt"

# --- Imports ---
COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common"
source "$COMMON_DIR/bootstrap.sh"

# --- Functions ---
function main() {
  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Formatting Nix files..."
  count=$(find "${FLAKE_PATH}" -name "*.nix" -type f | wc -l)
  find "${FLAKE_PATH}" -name "*.nix" -type f -exec nixfmt {} +
  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Formatted $count files"
}

main "$@"
