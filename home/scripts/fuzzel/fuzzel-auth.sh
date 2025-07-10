#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="rh-fuzzel-auth"
APP_TITLE="Rhodium's Auth Utils"
PROMPT="α: "

# --- Imports ---
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common/bootstrap.sh"
