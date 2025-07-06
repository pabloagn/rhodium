#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script shows flake metadata
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-flake-info"

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Functions ---
function main() {
    # This script's purpose is to print to terminal. No notification needed.
    nix flake metadata "${FLAKE_PATH}"
}

main "$@"
