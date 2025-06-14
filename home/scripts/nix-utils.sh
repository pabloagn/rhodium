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
HAS_RG=$(command -v rg &>/dev/null && echo true || echo false)
HAS_JQ=$(command -v jq &>/dev/null && echo true || echo false)

# Colors (simplified for compatibility)
if [[ -t 1 ]]; then
  readonly RED=$'\e[31m'
  readonly GREEN=$'\e[32m'
  readonly YELLOW=$'\e[33m'
  readonly BLUE=$'\e[34m'
  readonly PURPLE=$'\e[35m'
  readonly CYAN=$'\e[36m'
  readonly GRAY=$'\e[90m'
  readonly BOLD=$'\e[1m'
  readonly RESET=$'\e[0m'
else
  readonly RED='' GREEN='' YELLOW='' BLUE='' PURPLE='' CYAN='' GRAY='' BOLD='' RESET=''
fi

# Unicode symbols (with ASCII fallbacks)
if [[ "${TERM:-}" =~ (xterm|screen|tmux|rxvt|linux) ]]; then
  readonly SYM_SUCCESS="✓"
  readonly SYM_ERROR="✗"
  readonly SYM_WARNING="▲"
  readonly SYM_INFO="◆"
  readonly SYM_ARROW="→"
  readonly SYM_PACKAGE="▣"
else
  readonly SYM_SUCCESS="[OK]"
  readonly SYM_ERROR="[ERR]"
  readonly SYM_WARNING="[!]"
  readonly SYM_INFO="[i]"
  readonly SYM_ARROW="->"
  readonly SYM_PACKAGE="[P]"
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
  local timestamp=$(date '+%H:%M:%S')

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
  local hosts=$(get_hosts)
  local host_count=$(echo "$hosts" | wc -l)

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
  local available_hosts=$(get_hosts)

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
  local generations=$(sudo nix-env --list-generations --profile /nix/var/nix/profiles/system 2>/dev/null || true)

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
      local current_host=$(get_hosts | head -1)
      execute_cmd "sudo nixos-rebuild boot --flake '$FLAKE_DIR#$current_host'" "Updating boot menu"
    fi
  else
    log info "No generations selected"
  fi
}

# List installed packages
list_packages() {
  log header "System Package Inventory"

  # First, try to get packages from the current system
  local packages=""
  local source=""

  # Method 1: System packages from current-system
  if [[ -L "/run/current-system" ]]; then
    log info "Analyzing system packages..."

    # Get top-level packages
    local system_packages=$(nix-store -q --references /run/current-system |
      xargs -I {} basename {} |
      grep -v -E '^(system|nixos|etc|kernel|initrd|sw|firmware|systemd)' |
      sed 's/-[0-9].*//' |
      sort -u || true)

    if [[ -n "$system_packages" ]]; then
      packages="$system_packages"
      source="system configuration"
    fi
  fi

  # Method 2: User profile packages
  if [[ -z "$packages" ]] && command -v nix-env &>/dev/null; then
    local user_packages=$(nix-env -q 2>/dev/null | grep -v '^$' || true)
    if [[ -n "$user_packages" ]]; then
      packages="$user_packages"
      source="user profile"
    fi
  fi

  # Method 3: New nix profile (if nothing else worked)
  if [[ -z "$packages" ]] && command -v nix &>/dev/null; then
    # Parse nix profile list properly
    local profile_packages=$(nix profile list 2>/dev/null |
      awk '{
                # Extract package name from flake URIs like flake:nixpkgs#legacyPackages.x86_64-linux.hello
                if ($2 ~ /#/) {
                    split($2, parts, "#")
                    split(parts[2], pkg, "\\.")
                    print pkg[length(pkg)]
                }
                # For direct store paths
                else if ($2 ~ /\/nix\/store/) {
                    cmd = "basename " $2
                    cmd | getline basename_output
                    close(cmd)
                    # Remove version from basename
                    sub(/-[0-9].*/, "", basename_output)
                    print basename_output
                }
            }' | grep -v '^$' | sort -u || true)

    if [[ -n "$profile_packages" ]]; then
      packages="$profile_packages"
      source="nix profile"
    fi
  fi

  # Display results
  if [[ -z "$packages" ]]; then
    log info "No packages found in user profiles"
    echo
    echo "This is normal for declarative NixOS systems where packages are defined in configuration.nix"
    echo
    echo "To explore system packages, try:"
    echo "  - Check your configuration in: $FLAKE_DIR"
    echo "  - List all store paths: nix-store -q --requisites /run/current-system | wc -l"
    echo "  - Find specific packages: nix-store -q --requisites /run/current-system | grep <package>"
    return
  fi

  local pkg_count=$(echo "$packages" | grep -c . || echo 0)
  log info "Found ${BOLD}$pkg_count${RESET} packages in $source"
  echo

  # Display packages
  if [[ "$HAS_BAT" == "true" ]]; then
    echo "$packages" | head -20 | bat --style=plain --paging=never
  else
    echo "$packages" | head -20
  fi

  if [[ $pkg_count -gt 20 ]]; then
    echo
    echo "${YELLOW}Showing first 20 of $pkg_count packages${RESET}"

    if [[ "$HAS_FZF" == "true" ]]; then
      echo -n "View all interactively? (y/N): "
      read -r show_all

      if [[ "$show_all" =~ ^[Yy]$ ]]; then
        echo "$packages" | fzf \
          --height 80% \
          --prompt "Search packages: " \
          --header "Type to search"
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
  if [[ "$HAS_JQ" == "true" ]]; then
    jq -r '.nodes | to_entries[] | select(.key != "root") | "\(.key): \(.value.locked.lastModified // "unknown")"' "$FLAKE_DIR/flake.lock" 2>/dev/null | head -10
  else
    # Simple grep fallback
    grep -B2 '"lastModified"' "$FLAKE_DIR/flake.lock" | grep -E '"(nixpkgs|home-manager|[a-zA-Z-]+)":|lastModified' | paste - - | head -5
  fi

  execute_cmd "nix flake update '$FLAKE_DIR'" "Updating flake inputs"

  # Show updated state
  echo
  log info "Updated flake inputs:"
  if [[ "$HAS_JQ" == "true" ]]; then
    jq -r '.nodes | to_entries[] | select(.key != "root") | "\(.key): \(.value.locked.lastModified // "unknown")"' "$FLAKE_DIR/flake.lock" 2>/dev/null | head -10
  else
    grep -B2 '"lastModified"' "$FLAKE_DIR/flake.lock" | grep -E '"(nixpkgs|home-manager|[a-zA-Z-]+)":|lastModified' | paste - - | head -5
  fi
}

# Show system generations
show_generations() {
  log header "System Generation History"

  local generations=$(sudo nix-env --list-generations --profile /nix/var/nix/profiles/system 2>/dev/null || true)

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

  local hosts=$(get_hosts)
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
