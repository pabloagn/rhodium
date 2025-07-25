#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# Cache builder script - handles actual cache building operations
#

COMMON_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
source "${COMMON_DIR}/bootstrap.sh"

# --- Update Apps Cache ---
update_apps_cache() {
  (
    source "${COMMON_DIR}/build-cache-apps.sh"
    build_cache_apps
  )
}

# --- Update Launcher Cache ---
update_launcher_cache() {
  (
    source "${COMMON_DIR}/build-cache-launcher.sh"
    build_cache_launcher
  )
}

# --- Update Wallpapers Cache ---
update_wallpapers_cache() {
  (
    source "${COMMON_DIR}/build-cache-wallpapers.sh"
    build_cache_wallpapers
  )
}

# --- Update Bat Cache ---
update_bat_cache() {
  print_pending "Updating bat cache..."
  if bat cache --build; then
    print_success "Bat cache updated"
  else
    print_error "Failed to update bat cache"
    return 1
  fi
}

# --- Update Tldr Cache ---
update_tldr_cache() {
  print_pending "Updating tldr cache..."
  if tldr --update; then
    print_success "TLDR cache updated"
  else
    print_error "Failed to update tldr cache"
    return 1
  fi
}

# --- Update Unicode Icons Cache ---
update_icons_cache() {
  print_pending "Updating unicode icons cache..."
  if python3 "${COMMON_DIR}/build-icons-cache.py"; then
    print_success "Unicode icons cache updated"
  else
    print_error "Failed to update unicode icons cache"
    return 1
  fi
}

# --- Update Nix Index ---
update_nix_index() {
  print_pending "Updating nix index..."
  if nix-index; then
    print_success "Nix index updated"
  else
    print_error "Failed to update nix index"
    return 1
  fi
}

# --- Usage Function ---
show_usage() {
  echo "Usage: $0 [OPTIONS]"
  echo ""
  echo "OPTIONS:"
  echo "  --apps, -a              Update fuzzel apps cache"
  echo "  --launcher, -l          Update fuzzel launcher cache"
  echo "  --wallpapers, -w        Update fuzzel wallpapers cache"
  echo "  --bat, -b               Update bat syntax cache"
  echo "  --tldr, -t              Update tldr pages cache"
  echo "  --icons, -i             Update unicode icons cache"
  echo "  --nix, -n               Update nix index database"
  echo "  --all, -A               Update all caches"
  echo "  --all-except-nix, -e    Update all caches except nix index"
  echo "  --help, -h              Show this help message"
  echo ""
  echo "Examples:"
  echo "  $0 --fuzzel --bat"
  echo "  $0 -f -b -t"
  echo "  $0 --all"
}

# --- Main Function ---
main() {
  local run_apps=false
  local run_launcher=false
  local run_wallpapers=false
  local run_bat=false
  local run_tldr=false
  local run_icons=false
  local run_nix=false
  local has_operations=false

  # Parse command line arguments
  while [[ $# -gt 0 ]]; do
    case $1 in
    --apps | -a)
      run_apps=true
      has_operations=true
      shift
      ;;
    --launcher | -l)
      run_launcher=true
      has_operations=true
      shift
      ;;
    --wallpapers | -w)
      run_wallpapers=true
      has_operations=true
      shift
      ;;
    --bat | -b)
      run_bat=true
      has_operations=true
      shift
      ;;
    --tldr | -t)
      run_tldr=true
      has_operations=true
      shift
      ;;
    --icons | -i)
      run_icons=true
      has_operations=true
      shift
      ;;
    --nix | -n)
      run_nix=true
      has_operations=true
      shift
      ;;
    --all | -A)
      run_apps=true
      run_launcher=true
      run_wallpapers=true
      run_bat=true
      run_tldr=true
      run_icons=true
      run_nix=true
      has_operations=true
      shift
      ;;
    --all-except-nix | -e)
      run_apps=true
      run_launcher=true
      run_wallpapers=true
      run_bat=true
      run_tldr=true
      run_icons=true
      has_operations=true
      shift
      ;;
    --help | -h)
      show_usage
      exit 0
      ;;
    *)
      print_error "Unknown option: $1"
      show_usage
      exit 1
      ;;
    esac
  done

  # Show usage if no operations specified
  if [[ "$has_operations" == false ]]; then
    show_usage
    exit 1
  fi

  # Execute selected operations
  local failed_operations=()

  [[ "$run_apps" == true ]] && { update_apps_cache || failed_operations+=("apps"); }
  [[ "$run_launcher" == true ]] && { update_launcher_cache || failed_operations+=("launcher"); }
  [[ "$run_wallpapers" == true ]] && { update_wallpapers_cache || failed_operations+=("wallpapers"); }
  [[ "$run_bat" == true ]] && { update_bat_cache || failed_operations+=("bat"); }
  [[ "$run_tldr" == true ]] && { update_tldr_cache || failed_operations+=("tldr"); }
  [[ "$run_icons" == true ]] && { update_icons_cache || failed_operations+=("icons"); }
  [[ "$run_nix" == true ]] && { update_nix_index || failed_operations+=("nix"); }

  # Report results
  if [[ ${#failed_operations[@]} -eq 0 ]]; then
    print_success "All cache operations completed successfully!"
    exit 0
  else
    print_error "Some operations failed: ${failed_operations[*]}"
    exit 1
  fi
}

main "$@"
