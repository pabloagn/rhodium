#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script handles all garbage collection modes for NixOS generations
#

# --- Imports ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_DIR="$(dirname "$SCRIPT_DIR")/common"
source "${COMMON_DIR}/helpers.sh"

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
        red "Error: generations_to_keep must be a number"
        usage
    fi

    print_pending "Analyzing generations..."

    local current_gen=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | tail -1 | awk '{print $1}')
    local total_gens=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | wc -l)

    echo "  Current generation: $current_gen"
    echo "  Total generations: $total_gens"
    echo "  Generations to keep: $keep_count [plus current]"
    echo

    local gens_to_keep=$((keep_count + 1))

    if [ "$total_gens" -le "$gens_to_keep" ]; then
        print_partial "Nothing to collect [already at or below target]"
        return 0
    fi

    print_pending "Collecting garbage..."

    local keep_from=$((current_gen - keep_count))

    for gen in $(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | awk '{print $1}'); do
        if [ "$gen" -lt "$keep_from" ] && [ "$gen" != "$current_gen" ]; then
            echo "  Removing generation $gen..."
            sudo nix-env --delete-generations "$gen" -p /nix/var/nix/profiles/system 2>/dev/null || true
        fi
    done

    echo
    print_pending "Running garbage collector..."
    sudo nix-collect-garbage
    nix-collect-garbage

    local new_total=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | wc -l)
    echo
    print_success "Garbage collection complete"
    echo "  Remaining generations: $new_total"
}

function gc_days() {
    local days="${1:-7}"

    if ! [[ "$days" =~ ^[0-9]+$ ]]; then
        red "Error: days must be a number"
        usage
    fi

    print_pending "Collecting generations older than $days days..."
    sudo nix-collect-garbage --delete-older-than "${days}d"
    nix-collect-garbage --delete-older-than "${days}d"
    print_success "Garbage collection complete"
}

function gc_all() {
    print_pending "Cleaning all garbage..."
    sudo nix-collect-garbage -d
    nix-collect-garbage -d
    print_success "Garbage collection complete"
}

function main() {
    local mode="${1:-keep}"

    case "$mode" in
    keep)
        gc_keep "${2:-5}"
        ;;
    days)
        gc_days "${2:-7}"
        ;;
    all)
        gc_all
        ;;
    *)
        red "Unknown mode: $mode"
        usage
        ;;
    esac
}

main "$@"
