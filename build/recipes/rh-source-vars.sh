#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script sources user environment variables
#

# --- Imports ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_DIR="$(dirname "$SCRIPT_DIR")/common"
source "${COMMON_DIR}/helpers.sh"

# --- Functions ---
function main() {
    print_pending "Sourcing User Vars"
    if [ -f "/etc/profiles/per-user/${USER}/etc/profile.d/hm-session-vars.sh" ]; then
        source "/etc/profiles/per-user/${USER}/etc/profile.d/hm-session-vars.sh"
    fi
    print_success "Sourced User Vars"
}

main "$@"
