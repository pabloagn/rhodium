#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Handles all garbage collection modes for NixOS generations
#

# --- Main Configuration ---
APP_NAME="rh-build"
APP_TITLE="Rhodium Build"
RECIPE="rh-gc"

# --- Imports ---
COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../common"
source "$COMMON_DIR/bootstrap.sh"

# --- Functions ---
function usage() {
  echo "Usage:"
  echo "  $0 keep [generations]       - Keep N most recent generations (default: 5)"
  echo "  $0 days [days]              - Remove generations older than N days (default: 7)"
  echo "  $0 all                      - Remove all old generations"
  exit 1
}

function gc_keep() {
  local keep_count="${1:-5}"
  if ! [[ "$keep_count" =~ ^[0-9]+$ ]]; then
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} ERROR: generations_to_keep must be a number"
    usage
  fi

  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Analyzing generations..."
  local current_gen=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | tail -1 | awk '{print $1}')
  local total_gens=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | wc -l)
  local gens_to_keep=$((keep_count + 1))

  if [ "$total_gens" -le "$gens_to_keep" ]; then
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Nothing to collect [already at or below target]"
    return 0
  fi

  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Collecting garbage, keeping last $keep_count generations..."
  local keep_from=$((current_gen - keep_count))
  for gen in $(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | awk '{print $1}'); do
    if [ "$gen" -lt "$keep_from" ] && [ "$gen" != "$current_gen" ]; then
      sudo nix-env --delete-generations "$gen" -p /nix/var/nix/profiles/system 2>/dev/null || true
    fi
  done

  sudo nix-collect-garbage
  nix-collect-garbage
  local new_total=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | wc -l)
  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Garbage collection complete\nRemaining generations: $new_total"
}

function gc_days() {
  local days="${1:-7}"
  if ! [[ "$days" =~ ^[0-9]+$ ]]; then
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} ERROR: days must be a number"
    usage
  fi
  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Collecting generations older than $days days..."
  sudo nix-collect-garbage --delete-older-than "${days}d"
  nix-collect-garbage --delete-older-than "${days}d"
  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Garbage collection complete"
}

function gc_all() {
  # Collect Nix garbage
  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Cleaning Nix garbage..."
  sudo nix-collect-garbage -d
  nix-collect-garbage -d

  # Collect actual Trash
  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Cleaning Trash..."
  rm -rf "$XDG_DATA_HOME/share/Trash"

  # Notify complete
  notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} Garbage collection complete"

}

function main() {
  local mode="${1:-keep}"
  case "$mode" in
  keep) gc_keep "${2:-5}" ;;
  days) gc_days "${2:-7}" ;;
  all) gc_all ;;
  *)
    notify "$APP_TITLE" "$RECIPE:\n${NOTIFY_BULLET} ERROR: Unknown mode: $mode"
    usage
    ;;
  esac
}

main "$@"
