#!/usr/bin/env bash
# shellcheck disable=SC1091
#
# This script finds orphaned configuration directories with detailed analysis
#
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/rh-helpers.sh"

# Check if directory contains nix store symlinks
has_nix_symlinks() {
    local dir="$1"
    find "$dir" -type l -exec readlink {} \; 2>/dev/null | grep -q "/nix/store/"
}

# Get package name from various sources
get_package_names() {
    local tmpfile=$(mktemp)

    # Get packages from nix profile
    if command -v nix &>/dev/null; then
        nix profile list 2>/dev/null | awk -F'#' '{print $2}' | awk -F'.' '{print $NF}' | grep -v '^$' >>"$tmpfile"
    fi

    # Get packages from home-manager
    if command -v home-manager &>/dev/null; then
        home-manager packages 2>/dev/null | awk -F'-' 'NF>1{print $NF}' | grep -v '^$' >>"$tmpfile"
    fi

    # Also get full package names
    nix profile list 2>/dev/null | awk '{print $2}' | grep -v '^$' >>"$tmpfile"

    sort -u "$tmpfile"
    rm -f "$tmpfile"
}

# Check if config matches any installed package
is_package_installed() {
    local dirname="$1"
    local installed_list="$2"

    # Direct match
    grep -qiF "$dirname" "$installed_list" && return 0

    # Check common variations
    local variations=(
        "$dirname"
        "${dirname,,}"    # lowercase
        "${dirname^^}"    # uppercase
        "${dirname//-/_}" # dash to underscore
        "${dirname//_/-}" # underscore to dash
    )

    for var in "${variations[@]}"; do
        grep -qiF "$var" "$installed_list" && return 0
    done

    return 1
}

# Main function
main() {
    print_header "ORPHANED CONFIGURATIONS"

    # Get installed packages
    local pkg_list=$(mktemp)
    get_package_names >"$pkg_list"

    # Arrays for different categories
    declare -a managed_configs=()
    declare -a unmanaged_configs=()
    declare -a mixed_configs=()

    # Analyze each config directory
    while IFS= read -r -d '' dir; do
        local dirname=$(basename "$dir")

        # Skip system directories
        if is_system_directory "$dirname"; then
            continue
        fi

        # Skip if package is installed
        if is_package_installed "$dirname" "$pkg_list"; then
            continue
        fi

        # Get size
        local size=$(du -sh "$dir" 2>/dev/null | cut -f1)

        # Check for nix symlinks
        if has_nix_symlinks "$dir"; then
            # Check if ALL files are symlinks
            local total_files=$(find "$dir" -type f -o -type l | wc -l)
            local symlink_files=$(find "$dir" -type l | wc -l)

            if [[ $total_files -eq $symlink_files ]]; then
                managed_configs+=("$dirname|$size|$dir")
            else
                mixed_configs+=("$dirname|$size|$dir")
            fi
        else
            unmanaged_configs+=("$dirname|$size|$dir")
        fi
    done < <(find "${HOME_DIR}/.config" -maxdepth 1 -type d ! -path "${HOME_DIR}/.config" -print0)

    rm -f "$pkg_list"

    # Display results
    local total_orphans=$((${#managed_configs[@]} + ${#unmanaged_configs[@]} + ${#mixed_configs[@]}))

    if [[ $total_orphans -eq 0 ]]; then
        print_success "No orphaned configurations found!"
        return
    fi

    # Show unmanaged configs (highest priority for removal)
    if [[ ${#unmanaged_configs[@]} -gt 0 ]]; then
        echo
        red "▼ UNMANAGED CONFIGS (${#unmanaged_configs[@]}) - No Nix symlinks, safe to remove"
        cyan "$BAR_LIGHT"
        for config in "${unmanaged_configs[@]}"; do
            IFS='|' read -r name size path <<<"$config"
            printf "   %-30s %10s\n" "$name" "[$size]"
        done
    fi

    # Show mixed configs (review needed)
    if [[ ${#mixed_configs[@]} -gt 0 ]]; then
        echo
        yellow "◐ MIXED CONFIGS (${#mixed_configs[@]}) - Contains both managed and unmanaged files"
        cyan "$BAR_LIGHT"
        for config in "${mixed_configs[@]}"; do
            IFS='|' read -r name size path <<<"$config"
            printf "   %-30s %10s\n" "$name" "[$size]"
        done
    fi

    # Show fully managed configs (probably old)
    if [[ ${#managed_configs[@]} -gt 0 ]]; then
        echo
        green "▲ MANAGED CONFIGS (${#managed_configs[@]}) - All symlinks, from old generations"
        cyan "$BAR_LIGHT"
        for config in "${managed_configs[@]}"; do
            IFS='|' read -r name size path <<<"$config"
            printf "   %-30s %10s\n" "$name" "[$size]"
        done
    fi

    # Summary
    echo
    cyan "$BAR_HEAVY"
    echo "SUMMARY:"
    echo "  Total orphans: $total_orphans"
    echo "  Total size: $(du -sh ${HOME_DIR}/.config 2>/dev/null | cut -f1)"
    echo
    echo "NEXT STEPS:"
    echo "  • Run 'just clean-orphans' to interactively remove"
    echo "  • Start with unmanaged configs (safe to remove)"
    echo "  • Review mixed configs carefully"
}

main "$@"
