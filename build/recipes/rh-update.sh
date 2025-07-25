#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Handles flake input updates
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-update"

# --- Imports ---
COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common"
source "$COMMON_DIR/bootstrap.sh"

# --- Functions ---
function main() {
  if [ $# -eq 0 ]; then
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Updating all flake inputs..."
    nix flake update
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Flake inputs updated. See terminal for details."
    echo ""
    echo "Input changes:"
    git -C "${FLAKE_PATH}" diff flake.lock | grep -E "^\+" | grep -E "(lastModified|narHash)" | head -10 || true
  elif [ $# -eq 1 ]; then
    local input="$1"
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Updating input: $input..."
    nix flake update "$input"
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Updated input: $input"
  else
    echo "Usage: $0 [input]"
    echo "Update all flake inputs or a specific input"
    exit 1
  fi
}

main "$@"
