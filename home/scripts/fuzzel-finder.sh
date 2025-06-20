#!/usr/bin/env bash

# Variables
# --------------------------------------
# Fuzzel args
MENU_LEN=5
PADDING_ARGS_NIX_SEARCH="35 30 100"  # name, version, description

# Main menu options
declare -A menu_options=(
    ["⊹ Find Fonts"]="find_fonts"
    ["⊹ Find Installed Packages"]="find_installed_packages"
    ["⊹ Find Nix Packages"]="find_nix_packages"
    ["⊹ List Derivations"]="list_derivations"
)

# Find and display fonts
find_fonts() {
    local selected_font
    selected_font=$(fc-list --format="%{family[0]}\n" | sort | uniq | fuzzel --dmenu --prompt "Select Font: ")

    if [[ -n "$selected_font" ]]; then
        echo "Selected font: $selected_font"
        notify-send "Font Selected" "$selected_font" 2>/dev/null || echo "Font: $selected_font"
    fi
}

# Function to find installed packages (NixOS + Home Manager)
find_installed_packages() {
    local installed_packages=""

    installed_packages=$(nix-store --query --requisites /run/current-system |
        sed -E 's|/nix/store/[^-]+-||' |
        sort | uniq |
        grep -vE '\.patch$|\.tar\.|\.zip$|\.gz$|\.bz2$|\.xz$|source$|^\.drv$')

    # If home-manager profile exists, add those packages too
    if [[ -L "$HOME/.nix-profile" ]]; then
        local home_packages=$(nix-store --query --requisites "$HOME/.nix-profile" 2>/dev/null |
            sed -E 's|/nix/store/[^-]+-||' |
            sort | uniq |
            grep -vE '\.patch$|\.tar\.|\.zip$|\.gz$|\.bz2$|\.xz$|source$|^\.drv$')

        # Combine and deduplicate
        installed_packages=$(echo -e "$installed_packages\n$home_packages" | sort | uniq | grep -v '^$')
    fi

    if [[ -z "$installed_packages" ]]; then
        notify-send "Error" "No packages found" 2>/dev/null
        return
    fi

    local selected_package
    selected_package=$(echo "$installed_packages" | fuzzel --dmenu --prompt "Installed Packages: ")

    if [[ -n "$selected_package" ]]; then
        notify-send "Package Selected" "$selected_package" 2>/dev/null || echo "Package: $selected_package"
    fi
}

# Function to search for available Nix packages
# find_nix_packages() {
#     local search_term=""
#     local results=""
#
#     while true; do
#         # Get search term from user
#         search_term=$(echo "$search_term" | fuzzel --dmenu --prompt "Search packages: ")
#
#         # Exit if cancelled
#         [[ -z "$search_term" ]] && break
#
#         # Try different search methods in order of preference
#         if command -v nix-search &>/dev/null; then
#             results=$(nix-search --no-pager --no-color "$search_term" 2>/dev/null | head -100)
#         elif command -v nix-locate &>/dev/null; then
#             results=$(nix-locate --top-level --minimal "*$search_term*" 2>/dev/null | head -100)
#         else
#             results=$(nix --extra-experimental-features "nix-command flakes" search nixpkgs "$search_term" 2>/dev/null |
#                 grep -E "^\* " | sed 's/^\* //' | head -100)
#         fi
#
#         if [[ -z "$results" ]]; then
#             echo "No packages found for: $search_term" | fuzzel --dmenu --prompt "Press Enter to search again: "
#             continue
#         fi
#
#         # Show results
#         selected=$(echo "$results" | fuzzel --dmenu --prompt "Select package (ESC to search again): ")
#
#         if [[ -n "$selected" ]]; then
#             notify-send "Package Selected" "$selected" 2>/dev/null
#             break
#         fi
#     done
# }

find_nix_packages() {
    local search_term=""
    local selected=""
    local paddings=()
    read -ra paddings <<<"$PADDING_ARGS_NIX_SEARCH"

    while true; do
        search_term=$(echo "$search_term" | fuzzel --dmenu --prompt "Search packages: ")
        [[ -z "$search_term" ]] && break

        if command -v nix-search &>/dev/null; then
            local json
            json=$(nix-search --json "$search_term" 2>/dev/null)

            if [[ -z "$json" || "$json" == "[]" ]]; then
                echo "No packages found for: $search_term" | fuzzel --dmenu --prompt "Press Enter to search again: "
                continue
            fi

            local formatted_entries=()
            local raw_names=()

            # Prepare and format all results
            while IFS=$'\t' read -r name version description; do
                name="${name:-"-"}"
                version="${version:-"-"}"
                description="${description:-"-"}"
                description=${description//$'\n'/ }
                [[ ${#description} -gt 200 ]] && description="${description:0:200}..."

                formatted=$(printf "%-*s %-*s %-*s" \
                    "${paddings[0]}" "⊹ $name" \
                    "${paddings[1]}" "$version" \
                    "${paddings[2]}" "$description")
                formatted_entries+=("$formatted")
                raw_names+=("$name")
            done < <(
                echo "$json" | jq -r '.[] |
                    [
                        .name // "-",
                        .version // "-",
                        (.description // "-" | gsub("\n"; " "))
                    ] | @tsv'
            )

            # Display and select
            selected=$(printf '%s\n' "${formatted_entries[@]}" | fuzzel --dmenu --prompt "Select package: " -w 90)
            [[ -z "$selected" ]] && continue

            # Match back to real name
            for i in "${!formatted_entries[@]}"; do
                if [[ "${formatted_entries[$i]}" == "$selected" ]]; then
                    printf "%s" "${raw_names[$i]}" | wl-copy
                    notify-send -a "Fuzzel Finder" "Copied to Clipboard: ${raw_names[$i]}"
                    break
                fi
            done
            break

        elif command -v nix-locate &>/dev/null; then
            results=$(nix-locate --top-level --minimal "*$search_term*" 2>/dev/null | head -100)
            [[ -z "$results" ]] && continue
            selected=$(echo "$results" | fuzzel --dmenu --prompt "Select package (ESC to search again): ")
            [[ -n "$selected" ]] && {
                printf "%s" "$selected" | wl-copy
                notify-send "Copied to Clipboard" "$selected"
            }
            break

        else
            results=$(nix --extra-experimental-features "nix-command flakes" search nixpkgs "$search_term" 2>/dev/null |
                grep -E "^\* " | sed 's/^\* //' | head -100)
            [[ -z "$results" ]] && continue
            selected=$(echo "$results" | fuzzel --dmenu --prompt "Select package (ESC to search again): ")
            [[ -n "$selected" ]] && {
                printf "%s" "$selected" | wl-copy
                notify-send "Copied to Clipboard" "$selected"
            }
            break
        fi
    done
}

# Function to list cached derivations
list_derivations() {
    # Get derivations
    local derivations
    derivations=$(
        nix profile history --profile /nix/var/nix/profiles/system |
            sed 's/\x1B\[[0-9;]*m//g' |
            grep '^Version' |
            sed -E 's/://; s/·/ /g; s/\r//g; s/\x0D//g; s/\x0A//g' |
            sort
    )

    # Show info
    echo "$derivations" | fuzzel --dmenu -p "Nix Derivations: "
}

# Main menu loop
main() {
    while true; do
        local menu_items=""
        for key in "${!menu_options[@]}"; do
            menu_items="${menu_items}${key}\n"
        done

        local selected
        selected=$(echo -e "${menu_items}⊹ Exit" | fuzzel --dmenu --prompt "λ " -l $MENU_LEN)

        # Exit if cancelled or Exit selected
        [[ -z "$selected" ]] || [[ "$selected" == "⊹ Exit" ]] && break

        # Execute selected function
        if [[ -n "${menu_options[$selected]}" ]]; then
            ${menu_options[$selected]}
        fi
    done
}

# Run main function
main
