#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script shows system health status
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/rh-helpers.sh"

function check_flake_status() {
    print_pending "Flake Status"

    if git -C "$FLAKE_PATH" diff --quiet; then
        print_success "  No uncommitted changes"
    else
        print_partial "  Uncommitted changes present"
    fi

    local untracked=$(git -C "$FLAKE_PATH" ls-files --others --exclude-standard | wc -l)
    if [ "$untracked" -eq 0 ]; then
        print_success "  No untracked files"
    else
        print_partial "  $untracked untracked files"
    fi
}

function check_disk_usage() {
    print_pending "Disk Usage"

    local store_size=$(du -sh /nix/store 2>/dev/null | cut -f1)
    echo "  Nix store: $store_size"

    local root_usage=$(df -h / | tail -1 | awk '{print $5}')
    echo "  Root partition: $root_usage used"
}

function check_generations() {
    print_pending "Generations"

    local current_gen=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | tail -1 | awk '{print $1}')
    local total_gens=$(sudo nix-env --list-generations -p /nix/var/nix/profiles/system | wc -l)

    echo "  Current: $current_gen"
    echo "  Total: $total_gens"
}

function check_rhodium_services() {
    print_pending "Rhodium Services"

    for service in rh-swaybg rh-waybar rh-mako; do
        if systemctl --user is-active "$service.service" >/dev/null 2>&1; then
            print_success "  $service"
        else
            print_error "  $service"
        fi
    done
}

function main() {
    print_header "SYSTEM HEALTH"

    check_flake_status
    echo

    check_disk_usage
    echo

    check_generations
    echo

    check_rhodium_services
    echo

    cyan "$BAR_HEAVY"
}

main "$@"
