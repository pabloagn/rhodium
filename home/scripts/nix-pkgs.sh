#!/usr/bin/env bash

# NixOS Package Finder with fzf integration
# Usage: ./nix-pkgs.sh [search_term]

search_term="${1:-}"

# Function to get package metadata
get_package_info() {
    local pkg="$1"
    nix eval --json "nixpkgs#$pkg.meta" 2>/dev/null | jq -r '
        "Description: " + (.description // "N/A") + "\n" +
        "Homepage: " + (.homepage // "N/A") + "\n" +
        "License: " + (if .license.shortName then .license.shortName else (.license // "N/A") end) + "\n" +
        "Maintainers: " + (if .maintainers then ([.maintainers[] | .name // .github] | join(", ")) else "N/A" end) + "\n" +
        "Platforms: " + ((.platforms // []) | join(", "))
    ' 2>/dev/null || echo "Metadata unavailable"
}

# Function to search packages
search_packages() {
    if [[ -n "$search_term" ]]; then
        nix search nixpkgs "$search_term" --json 2>/dev/null | jq -r '
            to_entries[] | 
            .key as $attr | 
            .value |
            $attr + " | " + (.pname // "unknown") + " | " + (.version // "unknown") + " | " + (.description // "No description")
        '
    else
        # List all packages if no search term
        nix search nixpkgs --json 2>/dev/null | jq -r '
            to_entries[] | 
            .key as $attr | 
            .value |
            $attr + " | " + (.pname // "unknown") + " | " + (.version // "unknown") + " | " + (.description // "No description")
        '
    fi
}

# Main execution
if command -v fzf >/dev/null 2>&1; then
    # Use fzf for interactive selection
    selected=$(
        search_packages | fzf \
            --delimiter=' | ' \
            --with-nth=2,3,4 \
            --preview='
            pkg=$(echo {} | cut -d" | " -f1)
            echo "Package: $pkg"
            echo "===================="
            '"$(declare -f get_package_info)"'
            get_package_info "$pkg"
            echo ""
            echo "Installation:"
            echo "  nix-env -iA nixpkgs.$pkg"
            echo "  nix profile install nixpkgs#$pkg"
            echo ""
            echo "Nix shell:"
            echo "  nix shell nixpkgs#$pkg"
        ' \
            --preview-window='right:50%:wrap' \
            --header='Select package (Enter: show install commands, Ctrl-C: exit)' \
            --bind='enter:execute(
            pkg=$(echo {} | cut -d" | " -f1)
            echo "Package: $pkg"
            echo "===================="
            echo "Install with nix-env:"
            echo "  nix-env -iA nixpkgs.$pkg"
            echo ""
            echo "Install with nix profile:"
            echo "  nix profile install nixpkgs#$pkg"
            echo ""
            echo "Try in nix shell:"
            echo "  nix shell nixpkgs#$pkg"
            echo ""
            echo "Add to configuration.nix:"
            echo "  environment.systemPackages = [ pkgs.$pkg ];"
            echo ""
            echo "Add to home.nix:"
            echo "  home.packages = [ pkgs.$pkg ];"
            echo ""
            read -p "Press Enter to continue..."
        )'
    )
else
    # Fallback without fzf
    echo "Searching packages..."
    search_packages | while IFS=' | ' read -r attr pname version description; do
        echo "Package: $attr"
        echo "  Name: $pname"
        echo "  Version: $version"
        echo "  Description: $description"
        echo "  Install: nix profile install nixpkgs#$attr"
        echo ""
    done
fi
