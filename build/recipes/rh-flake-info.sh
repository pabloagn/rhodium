#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Shows flake metadata
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-flake-info"

# --- Imports ---
COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common"
source "$COMMON_DIR/bootstrap.sh"

# --- Functions ---
function main() {
  nix flake metadata "${FLAKE_PATH}"
}

main "$@"
