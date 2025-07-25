#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Bootstrap for common utils
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SHARED_FUNCTIONS="$PROJECT_ROOT/common/functions.sh"
SHARED_HELPERS="$PROJECT_ROOT/common/helpers.sh"

if [[ -f "$SHARED_FUNCTIONS" ]]; then
  source "$SHARED_FUNCTIONS"
else
  echo "Error: functions.sh not found at $SHARED_FUNCTIONS" >&2
  exit 1
fi

if [[ -f "$SHARED_HELPERS" ]]; then
  source "$SHARED_HELPERS"
else
  echo "Error: helpers.sh not found at $SHARED_HELPERS" >&2
  exit 1
fi
