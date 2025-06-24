#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rhodium-bluetooth"
APP_TITLE="Rhodium's Bluetooth Utils"
PROMPT="α: "

# --- Imports ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/shared-functions.sh" ]]; then
    source "$SCRIPT_DIR/shared-functions.sh"
else
    echo "Error: shared-functions.sh not found" >&2
    exit 1
fi
