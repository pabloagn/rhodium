#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Sources user environment variables
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-source-vars"

# --- Imports ---
COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common"
source "$COMMON_DIR/bootstrap.sh"

# --- Functions ---
function main() {
  notify "$APP_TITLE" "$RECIPE:\n◌Sourcing User Vars..."
  if [ -f "/etc/profiles/per-user/${USER}/etc/profile.d/hm-session-vars.sh" ]; then
    source "/etc/profiles/per-user/${USER}/etc/profile.d/hm-session-vars.sh"
  fi
  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Sourced User Vars"
}

main "$@"
