#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script rolls back to previous generation
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-rollback"

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Functions ---
function main() {
    notify "$APP_TITLE" "$RECIPE:\n◌Rolling back to previous generation..."
    sudo nixos-rebuild switch --rollback
    notify "$APP_TITLE" "$RECIPE:\n◌Rollback complete"
}

main "$@"
