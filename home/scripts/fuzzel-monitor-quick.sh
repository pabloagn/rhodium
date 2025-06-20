#!/usr/bin/env bash

set -euo pipefail

# --- Configuration ---
FUZZEL_DMENU_BASE_ARGS="--dmenu"

# --- Helper Functions ---

notify() {
    local title="$1"
    local message="$2"
    if command -v notify-send &>/dev/null; then
        notify-send "$title" "$message"
    else
        echo "Notification: $title - $message" >&2
    fi
}

run_fuzzel() {
    local prompt="$1"
    local input_data="$2"
    local extra_args="${3:-}"

    if [[ -z "$input_data" ]]; then
        fuzzel $FUZZEL_DMENU_BASE_ARGS $extra_args --prompt "$prompt"
    else
        echo "$input_data" | fuzzel $FUZZEL_DMENU_BASE_ARGS $extra_args --prompt "$prompt"
    fi
}

# Get monitor info from Niri
get_monitor_info() {
    local outputs_json=$(niri msg --json outputs 2>/dev/null || echo "[]")
    local monitors=()
    
    while IFS= read -r line; do
        monitors+=("$line")
    done < <(echo "$outputs_json" | jq -r '.[].name')
    
    echo "${monitors[@]}"
}

# Generate config example based on selection
generate_config_example() {
    local preset="$1"
    local monitors=($2)
    local primary="${monitors[0]:-eDP-1}"
    local external="${monitors[1]:-HDMI-A-1}"
    
    case "$preset" in
        "laptop-only")
            cat <<EOF
// Laptop Only Configuration
output "$primary" {
    mode "2880x1620@120"
    scale 1.5
    position x=0 y=0
}
output "$external" {
    off
}
EOF
            ;;
        "external-only")
            cat <<EOF
// External Only Configuration
output "$primary" {
    off
}
output "$external" {
    mode "3840x2160@60"
    scale 1.5
    position x=0 y=0
}
EOF
            ;;
        "extend-right")
            cat <<EOF
// Extend Right Configuration
output "$primary" {
    mode "2880x1620@120"
    scale 1.5
    position x=0 y=0
}
output "$external" {
    mode "3840x2160@60"
    scale 1.5
    position x=1920 y=0
}
EOF
            ;;
        "extend-left")
            cat <<EOF
// Extend Left Configuration
output "$external" {
    mode "3840x2160@60"
    scale 1.5
    position x=0 y=0
}
output "$primary" {
    mode "2880x1620@120"
    scale 1.5
    position x=2560 y=0
}
EOF
            ;;
        "mirror")
            cat <<EOF
// Mirror Configuration
output "$primary" {
    mode "1920x1080@60"
    scale 1.0
    position x=0 y=0
}
output "$external" {
    mode "1920x1080@60"
    scale 1.0
    position x=0 y=0
}
EOF
            ;;
    esac
}

# --- Main Menu ---

main() {
    # Get available monitors
    local monitors=($(get_monitor_info))
    
    local quick_options=$(cat <<EOF
⊹ Laptop Only
⊹ External Only
⊹ Extend Right
⊹ Extend Left
⊹ Mirror Displays
⊹ Open Display Manager
⊹ Edit Niri Config
EOF
)

    local num_options=7
    local menu_args="-l $num_options"

    local choice
    choice=$(run_fuzzel "Quick Display: " "$quick_options" "$menu_args") || exit 0

    case "$choice" in
        "⊹ Laptop Only")
            local config=$(generate_config_example "laptop-only" "${monitors[*]}")
            notify "Display Config" "$config"
            echo "$config" | wl-copy
            notify "Quick Display" "Laptop-only config copied to clipboard. Edit your Niri config and reload."
            ;;
        "⊹ External Only")
            local config=$(generate_config_example "external-only" "${monitors[*]}")
            notify "Display Config" "$config"
            echo "$config" | wl-copy
            notify "Quick Display" "External-only config copied to clipboard. Edit your Niri config and reload."
            ;;
        "⊹ Extend Right")
            local config=$(generate_config_example "extend-right" "${monitors[*]}")
            notify "Display Config" "$config"
            echo "$config" | wl-copy
            notify "Quick Display" "Extend-right config copied to clipboard. Edit your Niri config and reload."
            ;;
        "⊹ Extend Left")
            local config=$(generate_config_example "extend-left" "${monitors[*]}")
            notify "Display Config" "$config"
            echo "$config" | wl-copy
            notify "Quick Display" "Extend-left config copied to clipboard. Edit your Niri config and reload."
            ;;
        "⊹ Mirror Displays")
            local config=$(generate_config_example "mirror" "${monitors[*]}")
            notify "Display Config" "$config"
            echo "$config" | wl-copy
            notify "Quick Display" "Mirror config copied to clipboard. Edit your Niri config and reload."
            ;;
        "⊹ Open Display Manager")
            exec ~/.local/bin/fuzzel-display.sh
            ;;
        "⊹ Edit Niri Config")
            # Open the config in your preferred editor
            if command -v nvim &>/dev/null; then
                kitty -e nvim ~/.config/niri/config.kdl
            else
                notify "Quick Display" "Please edit ~/.config/niri/config.kdl manually"
            fi
            ;;
        *)
            notify "Quick Display" "Invalid option selected: $choice"
            ;;
    esac
}

main
