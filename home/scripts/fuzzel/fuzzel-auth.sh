#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rhodium-bluetooth"
APP_TITLE="Rhodium's Bluetooth Utils"
PROMPT="α: "

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"
