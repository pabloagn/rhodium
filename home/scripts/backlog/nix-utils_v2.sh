#!/usr/bin/env bash

# NixOS Flake Utility Script
# A robust CLI for managing NixOS flake configurations

set -euo pipefail

# Configuration
readonly SCRIPT_NAME=$(basename "$0")
readonly DEFAULT_HOST="host_001"
readonly FLAKE_DIR="${FLAKE_DIR:-.}"
readonly LOG_FILE="/tmp/nixos_utility_$$.log"

# Check for optional dependencies
HAS_FZF=$(command -v fzf &>/dev/null && echo true || echo false)
HAS_BAT=$(command -v bat &>/dev/null && echo true || echo false)
HAS_JQ=$(command -v jq &>/dev/null && echo true || echo false)

# Colors (simplified for compatibility)
if [[ -t 1 ]]; then
    readonly RED=$'\e[31m'
    readonly GREEN=$'\e[32m'
    readonly YELLOW=$'\e[33m'
    readonly PURPLE=$'\e[35m'
    readonly CYAN=$'\e[36m'
    readonly GRAY=$'\e[90m'
    readonly BOLD=$'\e[1m'
    readonly RESET=$'\e[0m'
else
    readonly RED='' GREEN='' YELLOW='' PURPLE='' CYAN='' GRAY='' BOLD='' RESET=''
fi

# Unicode symbols (with ASCII fallbacks)
if [[ "${TERM:-}" =~ (xterm|screen|tmux|rxvt|linux) ]]; then
    readonly SYM_SUCCESS="✓"
    readonly SYM_ERROR="✗"
    readonly SYM_WARNING="▲"
    readonly SYM_INFO="◆"
    readonly SYM_ARROW="→"
else
    readonly SYM_SUCCESS="[OK]"
    readonly SYM_ERROR="[ERR]"
    readonly SYM_WARNING="[!]"
    readonly SYM_INFO="[i]"
    readonly SYM_ARROW="->"
fi

# Cleanup on exit
cleanup() {
    [[ -f "$LOG_FILE" ]] && rm -f "$LOG_FILE"
}
trap cleanup EXIT

# Logging functions
log() {
    local level=$1
    shift
    local msg="$*"
    local timestamp
    timestamp=$(date '+%H:%M:%S')

    case $level in
    info)
        echo "${GRAY}[$timestamp]${RESET} ${CYAN}${SYM_INFO}${RESET} $msg"
        ;;
    success)
        echo "${GRAY}[$timestamp]${RESET} ${GREEN}${SYM_SUCCESS}${RESET} $msg"
        ;;
    error)
        echo "${GRAY}[$timestamp]${RESET} ${RED}${SYM_ERROR}${RESET} $msg" >&2
        ;;
    warning)
        echo "${GRAY}[$timestamp]${RESET} ${YELLOW}${SYM_WARNING}${RESET} $msg"
        ;;
    header)
        echo
        echo "${BOLD}${PURPLE}=== $msg ===${RESET}"
        ;;
    esac

    # Also log to file
    echo "[$timestamp] [$level] $msg" >>"$LOG_FILE"
}

# Error handler - only for actual errors, not help/normal exits
die() {
    local msg="$1"
    local exit_code="${2:-1}"
    log error "$msg"
    exit "$exit_code"
}

# Get available hosts from flake
get_hosts() {
    if [[ ! -f "$FLAKE_DIR/flake.nix" ]]; then
        echo "$DEFAULT_HOST"
        return
    fi

    # Try to get hosts from flake show
    if command -v nix &>/dev/null; then
        local hosts
        if [[ "$HAS_JQ" == "true" ]]; then
            hosts=$(nix flake show "$FLAKE_DIR" --json 2>/dev/null |
                jq -r '.nixosConfigurations | keys[]?' 2>/dev/null || true)
        else
            # Fallback without jq
            hosts=$(nix flake show "$FLAKE_DIR" 2>/dev/null |
                grep -E '^\s+[a-zA-Z0-9_-]+:' |
                grep -A1 "nixosConfigurations" |
                grep -v "nixosConfigurations" |
                awk '{print $1}' |
                sed 's/:$//' || true)
        fi

        if [[ -n "$hosts" ]]; then
            echo "$hosts" | sort -u
        else
            echo "$DEFAULT_HOST"
        fi
    else
        echo "$DEFAULT_HOST"
    fi
}

# Select host interactively
select_host() {
    local hosts
    hosts=$(get_hosts)
    local host_count
    host_count=$(echo "$hosts" | wc -l)

    # If only one host, use it
    if [[ $host_count -eq 1 ]]; then
        echo "$hosts"
        return
    fi

    # Use fzf if available
    if [[ "$HAS_FZF" == "true" ]]; then
        echo "$hosts" | fzf \
            --height 40% \
            --prompt "Select host: " \
            --header "Available NixOS configurations" || true
    else
        # Fallback to numbered selection
        echo "Available hosts:" >&2
        local i=1
        while IFS= read -r host; do
            echo "  $i) $host" >&2
            ((i++))
        done <<<"$hosts"

        echo -n "Select host (1-$host_count): " >&2
        read -r selection

        if [[ "$selection" =~ ^[0-9]+$ ]] && [[ $selection -ge 1 ]] && [[ $selection -le $host_count ]]; then
            echo "$hosts" | sed -n "${selection}p"
        else
            die "Invalid selection"
        fi
    fi
}

# Validate host exists
validate_host() {
    local host=$1
    local available_hosts
    available_hosts=$(get_hosts)

    if ! echo "$available_hosts" | grep -q "^$host$"; then
        log error "Host '$host' not found in flake configuration"
        echo "${YELLOW}Available hosts:${RESET}"
        echo "$available_hosts" | sed "s/^/  ${SYM_ARROW} /"
        return 1
    fi
}

# Execute command with output
execute_cmd() {
    local cmd="$1"
    local description="${2:-Executing command}"

    log info "$description..."
    echo "Command: $cmd" >>"$LOG_FILE"
    echo "---" >>"$LOG_FILE"

    if eval "$cmd" >>"$LOG_FILE" 2>&1; then
        log success "$description completed"
        return 0
    else
        local exit_code=$?
        log error "$description failed (exit code: $exit_code)"

        # Show last few lines of error
        if [[ -f "$LOG_FILE" ]]; then
            echo "${RED}Error output:${RESET}"
            tail -20 "$LOG_FILE" | sed 's/^/  /'
        fi

        return $exit_code
    fi
}

# Rebuild system
rebuild() {
    local host=${1:-}

    if [[ -z "$host" ]]; then
        host=$(select_host)
        [[ -z "$host" ]] && return 1
    fi

    validate_host "$host" || return 1

    log header "Rebuilding NixOS Configuration"
    log info "Target host: ${CYAN}$host${RESET}"

    execute_cmd "sudo nixos-rebuild switch --flake '$FLAKE_DIR#$host'" "Building and switching to new configuration"
}

# Test configuration
test_build() {
    local host=${1:-}

    if [[ -z "$host" ]]; then
        host=$(select_host)
        [[ -z "$host" ]] && return 1
    fi

    validate_host "$host" || return 1

    log header "Testing NixOS Configuration"
    log info "Target host: ${CYAN}$host${RESET}"

    execute_cmd "sudo nixos-rebuild test --flake '$FLAKE_DIR#$host'" "Testing configuration"
}

# Build without switching
build_only() {
    local host=${1:-}

    if [[ -z "$host" ]]; then
        host=$(select_host)
        [[ -z "$host" ]] && return 1
    fi

    validate_host "$host" || return 1

    log header "Building NixOS Configuration"
    log info "Target host: ${CYAN}$host${RESET}"

    execute_cmd "sudo nixos-rebuild build --flake '$FLAKE_DIR#$host'" "Building configuration"
}

# Clean old generations
clear_cache() {
    log header "System Cache Management"

    # Show current generations
    log info "Current system generations:"
    local generations
    generations=$(sudo nix-env --list-generations --profile /nix/var/nix/profiles/system 2>/dev/null || true)

    if [[ -z "$generations" ]]; then
        log warning "No generations found"
        return 1
    fi

    echo "$generations"
    echo

    # Get generations to delete
    local gen_nums=""

    if [[ "$HAS_FZF" == "true" ]]; then
        # Interactive selection with fzf
        gen_nums=$(echo "$generations" |
            awk '{print $1 " - " $3 " " $4}' |
            fzf --multi \
                --height 50% \
                --prompt "Select generations to delete (Tab for multi): " \
                --header "Use Tab to select multiple, Enter to confirm" |
            awk '{print $1}' | tr '\n' ' ' || true)
    else
        # Manual input
        echo -n "Enter generation numbers to delete (space-separated): "
        read -r gen_nums
    fi

    if [[ -n "$gen_nums" ]]; then
        log warning "About to delete generations: $gen_nums"
        echo -n "Continue? (y/N): "
        read -r confirm

        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            execute_cmd "sudo nix-env --delete-generations $gen_nums --profile /nix/var/nix/profiles/system" "Removing generations"
            execute_cmd "sudo nix-collect-garbage" "Collecting garbage"

            # Update bootloader
            local current_host
            current_host=$(get_hosts | head -1)
            execute_cmd "sudo nixos-rebuild boot --flake '$FLAKE_DIR#$current_host'" "Updating boot menu"
        fi
    else
        log info "No generations selected"
    fi
}

# List installed packages
list_packages() {
    log header "System Package Inventory"

    local all_packages=""
    local system_packages=""
    local home_packages=""

    # Method 1: Get system packages from environment.systemPackages
    if [[ -L "/run/current-system" ]]; then
        log info "Analyzing system packages..."

        # Get packages from system path
        local system_sw="/run/current-system/sw"
        if [[ -d "$system_sw/bin" ]]; then
            # Get all executables in system path and trace back to their packages
            system_packages=$(find "$system_sw/bin" -type l -exec readlink {} \; 2>/dev/null |
                grep -oE '/nix/store/[^/]+' |
                sort -u |
                xargs -I {} basename {} |
                sed 's/-[0-9].*//' |
                grep -v -E '^(system|nixos|etc|kernel|initrd|sw|firmware|systemd|perl|python|ruby)' |
                sort -u || true)
        fi

        if [[ -n "$system_packages" ]]; then
            log info "Found $(echo "$system_packages" | wc -l) system packages"
        fi
    fi

    # Method 2: Get home-manager packages
    local hm_profile_base="/nix/var/nix/profiles/per-user/$USER"
    local hm_profile=""

    # Find the home-manager profile
    if [[ -L "$hm_profile_base/home-manager" ]]; then
        hm_profile="$hm_profile_base/home-manager"
    elif [[ -L "$HOME/.nix-profile" ]] && [[ "$(readlink "$HOME/.nix-profile")" =~ home-manager ]]; then
        hm_profile="$HOME/.nix-profile"
    fi

    if [[ -n "$hm_profile" ]] && [[ -d "$hm_profile" ]]; then
        log info "Analyzing home-manager packages..."

        # Get packages from home-manager profile
        if [[ -d "$hm_profile/home-path/bin" ]]; then
            home_packages=$(find "$hm_profile/home-path/bin" -type l -exec readlink {} \; 2>/dev/null |
                grep -oE '/nix/store/[^/]+' |
                sort -u |
                xargs -I {} basename {} |
                sed 's/-[0-9].*//' |
                grep -v -E '^(home-manager|nix|perl|python|ruby)' |
                sort -u || true)
        fi

        if [[ -n "$home_packages" ]]; then
            log info "Found $(echo "$home_packages" | wc -l) home-manager packages"
        fi
    fi

    # Method 3: Check for imperatively installed packages
    local user_packages=""
    if command -v nix-env &>/dev/null; then
        user_packages=$(nix-env -q 2>/dev/null | grep -v -E '^(home-manager-path|$)' || true)
        if [[ -n "$user_packages" ]]; then
            log info "Found $(echo "$user_packages" | wc -l) user-installed packages"
        fi
    fi

    # Combine all packages and remove duplicates
    all_packages=$(echo -e "${system_packages}\n${home_packages}\n${user_packages}" |
        grep -v '^$' |
        sort -u)

    # Display results
    if [[ -z "$all_packages" ]]; then
        log warning "No packages found"
        echo
        echo "This might happen if packages are installed in non-standard ways."
        echo "Try checking:"
        echo "  - Your flake configuration in: $FLAKE_DIR"
        echo "  - System profile: /run/current-system/sw/bin/"
        echo "  - Home profile: $HOME/.nix-profile/bin/"
        return
    fi

    local pkg_count
    pkg_count=$(echo "$all_packages" | grep -c . || echo 0)
    log info "Total unique packages: ${BOLD}$pkg_count${RESET}"
    echo

    # Show breakdown if we have packages from multiple sources
    if [[ -n "$system_packages" ]] && [[ -n "$home_packages" ]]; then
        echo "${CYAN}Package sources:${RESET}"
        echo "  System: $(echo "$system_packages" | grep -c . || echo 0) packages"
        echo "  Home-manager: $(echo "$home_packages" | grep -c . || echo 0) packages"
        [[ -n "$user_packages" ]] && echo "  User (nix-env): $(echo "$user_packages" | grep -c . || echo 0) packages"
        echo
    fi

    # Display packages
    if [[ "$HAS_BAT" == "true" ]]; then
        echo "$all_packages" | head -30 | bat --style=plain --paging=never
    else
        echo "$all_packages" | head -30 | column
    fi

    if [[ $pkg_count -gt 30 ]]; then
        echo
        echo "${YELLOW}Showing first 30 of $pkg_count packages${RESET}"

        if [[ "$HAS_FZF" == "true" ]]; then
            echo -n "Search all packages interactively? (y/N): "
            read -r show_all

            if [[ "$show_all" =~ ^[Yy]$ ]]; then
                echo "$all_packages" | fzf \
                    --height 80% \
                    --prompt "Search packages: " \
                    --header "Type to search, ESC to exit" \
                    --preview-window=hidden
            fi
        else
            echo -n "Show all packages? (y/N): "
            read -r show_all

            if [[ "$show_all" =~ ^[Yy]$ ]]; then
                echo "$all_packages" | less
            fi
        fi
    fi
}

# Update flake inputs
flake_update() {
    log header "Updating Flake Inputs"

    if [[ ! -f "$FLAKE_DIR/flake.lock" ]]; then
        log warning "No flake.lock found in $FLAKE_DIR"
        return 1
    fi

    # Show current state
    log info "Current flake inputs:"
    # Just show the raw lastModified timestamps
    grep -B2 'lastModified' "$FLAKE_DIR/flake.lock" | grep -v '^--$' | head -20

    execute_cmd "nix flake update '$FLAKE_DIR'" "Updating flake inputs"

    # Show updated state
    echo
    log info "Updated flake inputs:"
    grep -B2 'lastModified' "$FLAKE_DIR/flake.lock" | grep -v '^--$' | head -20
}

# Show system generations
show_generations() {
    log header "System Generation History"

    local generations
    generations=$(sudo nix-env --list-generations --profile /nix/var/nix/profiles/system 2>/dev/null || true)

    if [[ -z "$generations" ]]; then
        log warning "No generations found"
        return 1
    fi

    if [[ "$HAS_BAT" == "true" ]]; then
        echo "$generations" | bat --style=numbers --paging=never
    else
        echo "$generations" | nl
    fi
}

# Show available hosts
show_hosts() {
    log header "Available NixOS Hosts"

    local hosts
    hosts=$(get_hosts)
    if [[ -z "$hosts" ]]; then
        log warning "No hosts found"
        return 1
    fi

    echo "$hosts" | while IFS= read -r host; do
        echo "  ${SYM_ARROW} $host"
    done
}

# Show help
show_help() {
    cat <<EOF
${BOLD}${PURPLE}NixOS Flake Utility${RESET}

${CYAN}Commands:${RESET}
  ${BOLD}rebuild${RESET} [HOST]     ${SYM_ARROW} Rebuild and switch to configuration
  ${BOLD}test${RESET} [HOST]        ${SYM_ARROW} Test configuration without switching
  ${BOLD}build${RESET} [HOST]       ${SYM_ARROW} Build configuration without switching
  ${BOLD}cache${RESET}              ${SYM_ARROW} Interactive cache and generation cleanup
  ${BOLD}packages${RESET}           ${SYM_ARROW} List and search installed packages
  ${BOLD}update${RESET}             ${SYM_ARROW} Update flake inputs
  ${BOLD}generations${RESET}        ${SYM_ARROW} Show system generations
  ${BOLD}hosts${RESET}              ${SYM_ARROW} List available hosts
  ${BOLD}help${RESET}               ${SYM_ARROW} Show this help

${CYAN}Examples:${RESET}
  $SCRIPT_NAME rebuild           ${SYM_ARROW} Interactive host selection and rebuild
  $SCRIPT_NAME rebuild myhost    ${SYM_ARROW} Rebuild specific host
  $SCRIPT_NAME test              ${SYM_ARROW} Test configuration interactively
  $SCRIPT_NAME cache             ${SYM_ARROW} Clean old generations

${CYAN}Environment:${RESET}
  FLAKE_DIR          ${SYM_ARROW} Flake directory (current: $FLAKE_DIR)

${GRAY}Optional tools: fzf ($([ "$HAS_FZF" == "true" ] && echo "found" || echo "not found")), bat ($([ "$HAS_BAT" == "true" ] && echo "found" || echo "not found"))${RESET}
EOF
}

# Main function
main() {
    local cmd="${1:-help}"
    shift || true

    case "$cmd" in
    rebuild | r)
        rebuild "$@"
        ;;
    test | t)
        test_build "$@"
        ;;
    build | b)
        build_only "$@"
        ;;
    cache | c)
        clear_cache
        ;;
    packages | p)
        list_packages
        ;;
    update | u)
        flake_update
        ;;
    generations | g)
        show_generations
        ;;
    hosts | h)
        show_hosts
        ;;
    help | --help | -h)
        show_help
        ;;
    *)
        log error "Unknown command: $cmd"
        echo
        show_help
        exit 1
        ;;
    esac
}

# Check if we're in a flake directory
if [[ ! -f "$FLAKE_DIR/flake.nix" ]]; then
    log warning "No flake.nix found in $FLAKE_DIR"
    echo -n "Continue anyway? (y/N): "
    read -r continue_anyway
    if [[ ! "$continue_anyway" =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Run main function
main "$@"
