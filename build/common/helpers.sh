#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# These are helper functions for formatting outputs and exporting env vars
#

# --- Configuration ---
export FLAKE_PATH="${FLAKE_PATH:-.}"
export MODULES_PATH="${MODULES_PATH:-${FLAKE_PATH}/build}"
export ASSETS_PATH="${ASSETS_PATH:-${FLAKE_PATH}/assets}"
export USER="${USER}"
export HOME_DIR="${HOME}"

# --- Unicode Symbols ---
export SYM_SUCCESS="▲"
export SYM_PENDING="❖"
export SYM_PARTIAL="◐"
export SYM_DOWN="▼"
export SYM_BULLET="▪"
export SYM_INFO="✗"
export BAR_HEAVY="━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
export BAR_LIGHT="─────────────────────────────────────────────────────────────────────────────"
export NOTIFY_BULLET="◌"

# --- Color Functions ---
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

# --- Print Functions With Symbols ---
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

# --- Header Printing ---
function print_header() {
    cyan "$BAR_HEAVY"
    cyan "${SYM_SUCCESS} $1"
    cyan "$BAR_HEAVY"
    echo
}

# --- Ask Yes Or No, With Yes Being The Default ---
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

# --- Ask Yes Or No, With No Being The Default ---
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

# --- Get Installed Packages List ---
function get_installed_packages() {
    local tmpfile=$(mktemp)
    nix-env -q | cut -d- -f1 | sort -u >"$tmpfile"
    home-manager packages 2>/dev/null | grep -E "^[a-zA-Z0-9-]+$" | sort -u >>"$tmpfile" || true
    echo "$tmpfile"
}

# --- Check If A Directory Is A System Directory That Should Be Preserved ---
function is_system_directory() {
    local dirname="$1"
    [[ "$dirname" =~ ^(systemd|fontconfig|gtk-[0-9]|user-dirs|mimeapps|dconf|pulse)$ ]]
}
