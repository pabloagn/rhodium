#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SHARED_FUNCTIONS="$PROJECT_ROOT/common/functions.sh"

if [[ -f "$SHARED_FUNCTIONS" ]]; then
    source "$SHARED_FUNCTIONS"
else
    echo "Error: functions.sh not found at $SHARED_FUNCTIONS" >&2
    exit 1
fi
