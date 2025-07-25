#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Rolls back to previous generation
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-rollback"

# --- Imports ---
COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common"
source "$COMMON_DIR/bootstrap.sh"

# --- Functions ---
function main() {
  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Rolling back to previous generation..."
  sudo nixos-rebuild switch --rollback
  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Rollback complete"
}

main "$@"
