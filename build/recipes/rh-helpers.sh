#!/usr/bin/env bash
set -eo pipefail

# Configuration
export FLAKE_PATH="${FLAKE_PATH:-.}"
export MODULES_PATH="${MODULES_PATH:-${FLAKE_PATH}/build}"
export ASSETS_PATH="${ASSETS_PATH:-${FLAKE_PATH}/assets}"
export USER="${USER}"
export HOME_DIR="${HOME}"

# Unicode Symbols
export SYM_SUCCESS="▲"
export SYM_PENDING="❖"
export SYM_PARTIAL="◐"
export SYM_DOWN="▼"
export SYM_BULLET="▪"
export SYM_INFO="✗"
export BAR_HEAVY="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
export BAR_LIGHT="─────────────────────────────────────────────────────────────────────────────"

# Color functions
function red() {
    echo -e "\033[0;31m$1\033[0m"
    if [ -n "${2-}" ]; then
        echo -e "\033[0;31m$($2)\033[0m"
    fi
}

function green() {
    echo -e "\033[0;32m$1\033[0m"
    if [ -n "${2-}" ]; then
        echo -e "\033[0;32m$($2)\033[0m"
    fi
}

function yellow() {
    echo -e "\033[0;33m$1\033[0m"
    if [ -n "${2-}" ]; then
        echo -e "\033[0;33m$($2)\033[0m"
    fi
}

function blue() {
    echo -e "\033[0;34m$1\033[0m"
    if [ -n "${2-}" ]; then
        echo -e "\033[0;34m$($2)\033[0m"
    fi
}

function magenta() {
    echo -e "\033[0;35m$1\033[0m"
    if [ -n "${2-}" ]; then
        echo -e "\033[0;35m$($2)\033[0m"
    fi
}

function cyan() {
    echo -e "\033[0;36m$1\033[0m"
    if [ -n "${2-}" ]; then
        echo -e "\033[0;36m$($2)\033[0m"
    fi
}

# Print functions with symbols
function print_pending() {
    yellow "${SYM_PENDING} $1"
}

function print_success() {
    green "${SYM_SUCCESS} $1"
}

function print_partial() {
    yellow "${SYM_PARTIAL} $1"
}

function print_error() {
    red "${SYM_DOWN} $1"
}

function print_info() {
    cyan "${SYM_BULLET} $1"
}

# Header printing
function print_header() {
    cyan "$BAR_HEAVY"
    cyan "${SYM_SUCCESS} $1"
    cyan "$BAR_HEAVY"
    echo
}

# Ask yes or no, with yes being the default
function yes_or_no() {
    echo -en "\033[0;34m[?] $* [y/n] (default: y): \033[0m"
    while true; do
        read -rp "" yn
        yn=${yn:-y}
        case $yn in
        [Yy]*) return 0 ;;
        [Nn]*) return 1 ;;
        esac
    done
}

# Ask yes or no, with no being the default
function no_or_yes() {
    echo -en "\033[0;34m[?] $* [y/n] (default: n): \033[0m"
    while true; do
        read -rp "" yn
        yn=${yn:-n}
        case $yn in
        [Yy]*) return 0 ;;
        [Nn]*) return 1 ;;
        esac
    done
}

# Get installed packages list
function get_installed_packages() {
    local tmpfile=$(mktemp)
    nix-env -q | cut -d- -f1 | sort -u >"$tmpfile"
    home-manager packages 2>/dev/null | grep -E "^[a-zA-Z0-9-]+$" | sort -u >>"$tmpfile" || true
    echo "$tmpfile"
}

# Check if a directory is a system directory that should be preserved
function is_system_directory() {
    local dirname="$1"
    [[ "$dirname" =~ ^(systemd|fontconfig|gtk-[0-9]|user-dirs|mimeapps|dconf|pulse)$ ]]
}
