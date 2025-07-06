#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script sources user environment variables
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-source-vars"

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"

# --- Functions ---
function main() {
    notify "$APP_TITLE" "$RECIPE:\n◌Sourcing User Vars..."
    if [ -f "/etc/profiles/per-user/${USER}/etc/profile.d/hm-session-vars.sh" ]; then
        source "/etc/profiles/per-user/${USER}/etc/profile.d/hm-session-vars.sh"
    fi
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Sourced User Vars"
}

main "$@"
