#!/usr/bin/env bash

set -euo pipefail

# --- Configuration ---
FUZZEL_DMENU_BASE_ARGS="--dmenu"
MAX_DYNAMIC_LINES=15

# Common display configurations
declare -A COMMON_RESOLUTIONS=(
    ["1080p"]="1920x1080"
    ["1440p"]="2560x1440"
    ["4K"]="3840x2160"
    ["UWQHD"]="3440x1440"
    ["WQHD"]="2560x1600"
    ["Laptop HD+"]="2880x1620"
)

declare -A COMMON_REFRESH_RATES=(
    ["Standard"]="60"
    ["Gaming"]="120"
    ["High Refresh"]="144"
    ["Ultra High"]="240"
)

declare -A COMMON_SCALES=(
    ["100%"]="1.0"
    ["125%"]="1.25"
    ["150%"]="1.5"
    ["175%"]="1.75"
    ["200%"]="2.0"
)

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

# Get current outputs information from Niri
get_outputs_info() {
    niri msg --json outputs 2>/dev/null || echo "[]"
}

# Parse output information
parse_output_info() {
    local outputs_json="$1"
    echo "$outputs_json" | jq -r '.[] | "\(.name)|\(.make // "Unknown") \(.model // "Unknown")|\(.current_mode.width // 0)x\(.current_mode.height // 0)@\(.current_mode.refresh_rate // 0)|\(.scale // 1.0)|\(.logical.x // 0)x\(.logical.y // 0)"'
}

# Get available modes for a specific output
get_output_modes() {
    local output_name="$1"
    local outputs_json=$(get_outputs_info)
    echo "$outputs_json" | jq -r --arg name "$output_name" '.[] | select(.name == $name) | .modes[] | "\(.width)x\(.height)@\(.refresh_rate)"' | sort -u
}

# --- Display Actions ---

# List all connected displays with their current configuration
list_displays() {
    local outputs_json=$(get_outputs_info)
    if [[ "$outputs_json" == "[]" ]]; then
        notify "Display Manager" "No displays found."
        return 0
    fi

    local formatted_list_array=()
    while IFS='|' read -r name description resolution scale position; do
        local entry="⊹ $name: $description"
        entry+="\n  └─ Resolution: $resolution, Scale: $scale, Position: $position"
        formatted_list_array+=("$entry")
    done < <(parse_output_info "$outputs_json")

    local num_options=${#formatted_list_array[@]}
    local display_lines=$((num_options < MAX_DYNAMIC_LINES ? num_options : MAX_DYNAMIC_LINES))
    local menu_lines_arg="-l $display_lines"

    run_fuzzel "Connected Displays: " "$(printf "%s\n" "${formatted_list_array[@]}")" "$menu_lines_arg" || true
}

# Configure single display
configure_single_display() {
    local outputs_json=$(get_outputs_info)
    local output_names=($(echo "$outputs_json" | jq -r '.[].name'))

    if [[ ${#output_names[@]} -eq 0 ]]; then
        notify "Display Manager" "No displays found."
        return 1
    fi

    local formatted_list_array=()
    for name in "${output_names[@]}"; do
        formatted_list_array+=("⊹ $name")
    done

    local selected_output
    selected_output=$(run_fuzzel "Select Display: " "$(printf "%s\n" "${formatted_list_array[@]}")" "-l ${#output_names[@]}") || return 1
    selected_output=${selected_output#⊹ } # Remove the symbol

    # Show configuration options
    local config_options=$(
        cat <<EOF
⊹ Change Resolution
⊹ Change Refresh Rate
⊹ Change Scale
⊹ Change Position
⊹ Enable Display
⊹ Disable Display
⊹ Set as Primary
EOF
    )

    local choice
    choice=$(run_fuzzel "Configure $selected_output: " "$config_options" "-l 7") || return 1

    case "$choice" in
    "⊹ Change Resolution")
        change_resolution "$selected_output"
        ;;
    "⊹ Change Refresh Rate")
        change_refresh_rate "$selected_output"
        ;;
    "⊹ Change Scale")
        change_scale "$selected_output"
        ;;
    "⊹ Change Position")
        change_position "$selected_output"
        ;;
    "⊹ Enable Display")
        enable_display "$selected_output"
        ;;
    "⊹ Disable Display")
        disable_display "$selected_output"
        ;;
    "⊹ Set as Primary")
        set_primary_display "$selected_output"
        ;;
    esac
}

# Change display resolution
change_resolution() {
    local output_name="$1"
    local available_modes=$(get_output_modes "$output_name")

    if [[ -z "$available_modes" ]]; then
        notify "Display Manager" "No modes available for $output_name"
        return 1
    fi

    local formatted_modes=()
    while IFS= read -r mode; do
        formatted_modes+=("⊹ $mode")
    done <<<"$available_modes"

    local selected_mode
    selected_mode=$(run_fuzzel "Select Resolution for $output_name: " "$(printf "%s\n" "${formatted_modes[@]}")" "-l ${#formatted_modes[@]}") || return 1
    selected_mode=${selected_mode#⊹ } # Remove the symbol

    # Extract resolution and refresh rate
    local resolution=$(echo "$selected_mode" | cut -d'@' -f1)
    local refresh=$(echo "$selected_mode" | cut -d'@' -f2)

    notify "Display Manager" "Setting $output_name to $resolution@${refresh}Hz..."

    # Update the Niri config file directly (since Niri doesn't have runtime output configuration yet)
    # This is a placeholder - you'll need to implement config file editing
    notify "Display Manager" "Note: Niri requires config file changes for output settings. Edit your config and reload."
}

# Quick display presets
apply_preset() {
    local preset_options=$(
        cat <<EOF
⊹ Laptop Only
⊹ External Only
⊹ Extend Right
⊹ Extend Left
⊹ Mirror Displays
⊹ External Above
⊹ External Below
⊹ Dual Side-by-Side
⊹ Gaming Mode (High Refresh)
⊹ Presentation Mode
EOF
    )

    local choice
    choice=$(run_fuzzel "Display Presets: " "$preset_options" "-l 10") || return 1

    case "$choice" in
    "⊹ Laptop Only")
        apply_laptop_only
        ;;
    "⊹ External Only")
        apply_external_only
        ;;
    "⊹ Extend Right")
        apply_extend_right
        ;;
    "⊹ Extend Left")
        apply_extend_left
        ;;
    "⊹ Mirror Displays")
        apply_mirror
        ;;
    "⊹ External Above")
        apply_external_above
        ;;
    "⊹ External Below")
        apply_external_below
        ;;
    "⊹ Dual Side-by-Side")
        apply_dual_side_by_side
        ;;
    "⊹ Gaming Mode (High Refresh)")
        apply_gaming_mode
        ;;
    "⊹ Presentation Mode")
        apply_presentation_mode
        ;;
    esac
}

# Apply laptop only preset
apply_laptop_only() {
    notify "Display Manager" "Note: Edit Niri config to disable external displays and reload."
    # Provide example config
    local example=$(
        cat <<EOF
Example config:
output "eDP-1" {
    mode "2880x1620@120"
    scale 1.5
    position x=0 y=0
}
output "HDMI-A-1" {
    off
}
EOF
    )
    notify "Display Manager Example" "$example"
}

# VRR (Variable Refresh Rate) settings
configure_vrr() {
    local outputs_json=$(get_outputs_info)
    local output_names=($(echo "$outputs_json" | jq -r '.[].name'))

    if [[ ${#output_names[@]} -eq 0 ]]; then
        notify "Display Manager" "No displays found."
        return 1
    fi

    local formatted_list_array=()
    for name in "${output_names[@]}"; do
        formatted_list_array+=("⊹ $name")
    done

    local selected_output
    selected_output=$(run_fuzzel "Select Display for VRR: " "$(printf "%s\n" "${formatted_list_array[@]}")" "-l ${#output_names[@]}") || return 1
    selected_output=${selected_output#⊹ }

    local vrr_options=$(
        cat <<EOF
⊹ Enable VRR
⊹ Disable VRR
⊹ On-Demand VRR
EOF
    )

    local choice
    choice=$(run_fuzzel "VRR Settings for $selected_output: " "$vrr_options" "-l 3") || return 1

    case "$choice" in
    "⊹ Enable VRR")
        notify "Display Manager" "Add 'variable-refresh-rate true' to $selected_output in config"
        ;;
    "⊹ Disable VRR")
        notify "Display Manager" "Set 'variable-refresh-rate false' for $selected_output in config"
        ;;
    "⊹ On-Demand VRR")
        notify "Display Manager" "Set 'variable-refresh-rate on-demand=true' for $selected_output in config"
        ;;
    esac
}

# Advanced display settings
advanced_settings() {
    local advanced_options=$(
        cat <<EOF
⊹ Configure Transforms (Rotation)
⊹ Configure Color Profile
⊹ Configure HDR Settings
⊹ Export Current Configuration
⊹ Import Configuration
⊹ Reset to Defaults
EOF
    )

    local choice
    choice=$(run_fuzzel "Advanced Display Settings: " "$advanced_options" "-l 6") || return 1

    case "$choice" in
    "⊹ Configure Transforms (Rotation)")
        configure_transforms
        ;;
    "⊹ Configure Color Profile")
        notify "Display Manager" "Color profiles can be set using 'output { color-profile \"path/to/profile.icc\" }'"
        ;;
    "⊹ Configure HDR Settings")
        notify "Display Manager" "HDR support depends on your hardware and Niri version"
        ;;
    "⊹ Export Current Configuration")
        export_configuration
        ;;
    "⊹ Import Configuration")
        notify "Display Manager" "Copy configuration to your Niri config file and reload"
        ;;
    "⊹ Reset to Defaults")
        notify "Display Manager" "Remove output sections from config to use auto-detection"
        ;;
    esac
}

# Configure display transforms (rotation)
configure_transforms() {
    local outputs_json=$(get_outputs_info)
    local output_names=($(echo "$outputs_json" | jq -r '.[].name'))

    local formatted_list_array=()
    for name in "${output_names[@]}"; do
        formatted_list_array+=("⊹ $name")
    done

    local selected_output
    selected_output=$(run_fuzzel "Select Display: " "$(printf "%s\n" "${formatted_list_array[@]}")" "-l ${#output_names[@]}") || return 1
    selected_output=${selected_output#⊹ }

    local transform_options=$(
        cat <<EOF
⊹ Normal (0°)
⊹ Rotate 90° Clockwise
⊹ Rotate 180°
⊹ Rotate 270° Clockwise
⊹ Flipped
⊹ Flipped + 90°
⊹ Flipped + 180°
⊹ Flipped + 270°
EOF
    )

    local choice
    choice=$(run_fuzzel "Transform for $selected_output: " "$transform_options" "-l 8") || return 1

    local transform_value
    case "$choice" in
    "⊹ Normal (0°)") transform_value="normal" ;;
    "⊹ Rotate 90° Clockwise") transform_value="90" ;;
    "⊹ Rotate 180°") transform_value="180" ;;
    "⊹ Rotate 270° Clockwise") transform_value="270" ;;
    "⊹ Flipped") transform_value="flipped" ;;
    "⊹ Flipped + 90°") transform_value="flipped-90" ;;
    "⊹ Flipped + 180°") transform_value="flipped-180" ;;
    "⊹ Flipped + 270°") transform_value="flipped-270" ;;
    esac

    notify "Display Manager" "Add 'transform \"$transform_value\"' to $selected_output in config"
}

# Export current configuration
export_configuration() {
    local outputs_json=$(get_outputs_info)
    local config_file="/tmp/niri-display-config-$(date +%Y%m%d-%H%M%S).txt"

    {
        echo "# Niri Display Configuration Export"
        echo "# Generated on $(date)"
        echo ""

        echo "$outputs_json" | jq -r '.[] | 
            "output \"\(.name)\" {\n" +
            "    mode \"\(.current_mode.width)x\(.current_mode.height)@\(.current_mode.refresh_rate)\"\n" +
            "    scale \(.scale // 1.0)\n" +
            "    position x=\(.logical.x // 0) y=\(.logical.y // 0)\n" +
            "}"'
    } >"$config_file"

    notify "Display Manager" "Configuration exported to $config_file"
}

# --- Main Menu ---

main() {
    local main_menu_options=$(
        cat <<EOF
⊹ List Connected Displays
⊹ Configure Single Display
⊹ Apply Display Preset
⊹ Variable Refresh Rate (VRR)
⊹ Advanced Settings
⊹ Reload Niri Config
EOF
    )

    local num_main_options=6
    local main_menu_specific_args="-l $num_main_options"

    local choice
    choice=$(run_fuzzel "Display Manager: " "$main_menu_options" "$main_menu_specific_args") || exit 0

    case "$choice" in
    "⊹ List Connected Displays")
        list_displays
        ;;
    "⊹ Configure Single Display")
        configure_single_display
        ;;
    "⊹ Apply Display Preset")
        apply_preset
        ;;
    "⊹ Variable Refresh Rate (VRR)")
        configure_vrr
        ;;
    "⊹ Advanced Settings")
        advanced_settings
        ;;
    "⊹ Reload Niri Config")
        notify "Display Manager" "Reloading Niri configuration..."
        niri msg reload-config
        ;;
    *)
        notify "Display Manager" "Invalid option selected: $choice"
        ;;
    esac
}

main
