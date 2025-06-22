#!/usr/bin/env bash

set -euo pipefail

# --- Main Configuration ---
APP_NAME="niri-display-manager"
APP_TITLE="Display Manager"

# --- Imports ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/shared-functions.sh" ]]; then
    source "$SCRIPT_DIR/shared-functions.sh"
else
    echo "Error: shared-functions.sh not found" >&2
    exit 1
fi

# --- Variables ---
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/$APP_NAME"
MAX_DYNAMIC_LINES=15

# Common display configurations
declare -A COMMON_RESOLUTIONS=(
    ["1080p"]="1920x1080"
    ["1440p"]="2560x1440"
    ["4K"]="3840x2160"
    ["UWQHD"]="3440x1440"
    ["WQHD"]="2560x1600"
    ["HD+"]="2880x1620"
)

declare -A COMMON_REFRESH_RATES=(
    ["60Hz"]="60000"
    ["120Hz"]="120000"
    ["144Hz"]="144000"
    ["240Hz"]="240000"
)

declare -A COMMON_SCALES=(
    ["100%"]="1.0"
    ["125%"]="1.25"
    ["150%"]="1.5"
    ["175%"]="1.75"
    ["200%"]="2.0"
)

# --- Helper Functions ---
get_outputs_info() {
    niri msg --json outputs 2>/dev/null || echo "{}"
}

format_refresh_rate() {
    local mhz="$1"
    local hz=$(( mhz / 1000 ))
    echo "${hz}Hz"
}

# --- Display Actions ---
list_displays() {
    local outputs_json=$(get_outputs_info)
    if [[ "$outputs_json" == "{}" ]]; then
        notify "$APP_TITLE" "No displays found."
        return 0
    fi
    
    local display_list=""
    local count=0
    
    # Process each display
    while IFS=$'\t' read -r name make model width height refresh scale position_x position_y; do
        ((count++))
        local hz=$(format_refresh_rate "$refresh")
        local display_info="${make} ${model}"
        if [[ ${#display_info} -gt 25 ]]; then
            display_info="${display_info:0:22}..."
        fi
        if [[ -n "$display_list" ]]; then
            display_list+="\n"
        fi
        display_list+="⊹ $(printf "%-10s %-25s %4dx%-4d @%-6s x%-3s" \
            "$name" "$display_info" "$width" "$height" "$hz" "$scale")"
    done < <(echo "$outputs_json" | jq -r 'to_entries[] | [
        .key,
        (.value.make // "Unknown"),
        (.value.model // "Unknown"),
        (.value.logical.width // 0),
        (.value.logical.height // 0),
        ((.value.modes[] | select(.is_preferred == true) | .refresh_rate) // 60000),
        (.value.logical.scale // 1.0),
        (.value.logical.x // 0),
        (.value.logical.y // 0)
    ] | @tsv')
    
    echo -e "$display_list" 
}

configure_single_display() {
    local outputs_json=$(get_outputs_info)
    local output_names=($(echo "$outputs_json" | jq -r 'keys[]'))
    
    if [[ ${#output_names[@]} -eq 0 ]]; then
        notify "$APP_TITLE" "No displays found."
        return 1
    fi
    
    local display_list=""
    for name in "${output_names[@]}"; do
        if [[ -n "$display_list" ]]; then
            display_list+="\n"
        fi
        display_list+="⊹ $name"
    done
    
    local selected_output
    selected_output=$(echo -e "$display_list" | fuzzel --dmenu --prompt="Select Display: " -l ${#output_names[@]}) || return 1
    selected_output=${selected_output#⊹ }
    
    local running=true
    while $running; do
        local config_options=$(
            cat <<EOF
⊹ Change Resolution
⊹ Change Scale
⊹ Change Position
⊹ Configure Rotation
⊹ Toggle Display
⊹ ← Back
EOF
        )
        
        local choice
        choice=$(echo "$config_options" | fuzzel --dmenu --prompt="Configure $selected_output: " -l 6) || return 1
        
        case "$choice" in
        "⊹ Change Resolution")
            change_resolution "$selected_output"
            ;;
        "⊹ Change Scale")
            change_scale "$selected_output"
            ;;
        "⊹ Change Position")
            change_position "$selected_output"
            ;;
        "⊹ Configure Rotation")
            configure_rotation "$selected_output"
            ;;
        "⊹ Toggle Display")
            toggle_display "$selected_output"
            ;;
        "⊹ ← Back")
            running=false
            ;;
        esac
    done
}

change_resolution() {
    local output_name="$1"
    local outputs_json=$(get_outputs_info)
    
    local modes_list=""
    local count=0
    
    while IFS=$'\t' read -r width height refresh; do
        ((count++))
        local hz=$(format_refresh_rate "$refresh")
        if [[ -n "$modes_list" ]]; then
            modes_list+="\n"
        fi
        modes_list+="⊹ ${width}x${height} @ ${hz}"
    done < <(echo "$outputs_json" | jq -r --arg name "$output_name" '
        .[$name].modes[] | [.width, .height, .refresh_rate] | @tsv' | sort -u)
    
    if [[ $count -eq 0 ]]; then
        notify "$APP_TITLE" "No modes available for $output_name"
        return 1
    fi
    
    local selected
    selected=$(echo -e "$modes_list" | fuzzel --dmenu --prompt="Select Resolution: " -l $count) || return 0
    
    if [[ -n "$selected" ]]; then
        local resolution=$(echo "$selected" | grep -oE '[0-9]+x[0-9]+')
        local refresh=$(echo "$selected" | grep -oE '[0-9]+Hz')
        
        notify "$APP_TITLE" "Add to config:\n\noutput \"$output_name\" {\n    mode \"${resolution}@${refresh%%Hz}\"\n}\n\nThen reload: niri msg reload-config"
    fi
}

change_scale() {
    local output_name="$1"
    local scale_options=$(
        cat <<EOF
⊹ 100%
⊹ 125%
⊹ 150%
⊹ 175%
⊹ 200%
EOF
    )
    
    local selected
    selected=$(echo "$scale_options" | fuzzel --dmenu --prompt="Select Scale: " -l 5) || return 0
    
    if [[ -n "$selected" ]]; then
        local scale_value="${COMMON_SCALES[${selected#⊹ }]}"
        notify "$APP_TITLE" "Add to config:\n\noutput \"$output_name\" {\n    scale $scale_value\n}\n\nThen reload: niri msg reload-config"
    fi
}

change_position() {
    local output_name="$1"
    local position_options=$(
        cat <<EOF
⊹ Set to Origin (0,0)
⊹ Right of Primary
⊹ Left of Primary
⊹ Above Primary
⊹ Below Primary
⊹ Custom Position
EOF
    )
    
    local choice
    choice=$(echo "$position_options" | fuzzel --dmenu --prompt="Position $output_name: " -l 6) || return 0
    
    case "$choice" in
    "⊹ Set to Origin (0,0)")
        notify "$APP_TITLE" "Add to config:\n\noutput \"$output_name\" {\n    position x=0 y=0\n}"
        ;;
    "⊹ Custom Position")
        notify "$APP_TITLE" "Use 'position x=X y=Y' in config"
        ;;
    *)
        notify "$APP_TITLE" "Calculate position based on primary display dimensions"
        ;;
    esac
}

configure_rotation() {
    local output_name="$1"
    local rotation_options=$(
        cat <<EOF
⊹ Normal (0°)
⊹ 90° Clockwise
⊹ 180° Upside Down
⊹ 270° Counter-Clockwise
⊹ Flipped Horizontal
⊹ Flipped Vertical
EOF
    )
    
    local choice
    choice=$(echo "$rotation_options" | fuzzel --dmenu --prompt="Rotate $output_name: " -l 6) || return 0
    
    local transform=""
    case "$choice" in
    "⊹ Normal (0°)") transform="normal" ;;
    "⊹ 90° Clockwise") transform="90" ;;
    "⊹ 180° Upside Down") transform="180" ;;
    "⊹ 270° Counter-Clockwise") transform="270" ;;
    "⊹ Flipped Horizontal") transform="flipped" ;;
    "⊹ Flipped Vertical") transform="flipped-180" ;;
    esac
    
    if [[ -n "$transform" ]]; then
        notify "$APP_TITLE" "Add to config:\n\noutput \"$output_name\" {\n    transform \"$transform\"\n}"
    fi
}

toggle_display() {
    local output_name="$1"
    local toggle_options=$(
        cat <<EOF
⊹ Enable Display
⊹ Disable Display
EOF
    )
    
    local choice
    choice=$(echo "$toggle_options" | fuzzel --dmenu --prompt="Toggle $output_name: " -l 2) || return 0
    
    case "$choice" in
    "⊹ Enable Display")
        notify "$APP_TITLE" "Remove 'off' from output \"$output_name\" in config"
        ;;
    "⊹ Disable Display")
        notify "$APP_TITLE" "Add to config:\n\noutput \"$output_name\" {\n    off\n}"
        ;;
    esac
}

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
⊹ Gaming Mode
⊹ Presentation Mode
EOF
    )
    
    local choice
    choice=$(echo "$preset_options" | fuzzel --dmenu --prompt="Display Presets: " -l 9) || return 1
    
    local outputs_json=$(get_outputs_info)
    local laptop_display=$(echo "$outputs_json" | jq -r 'to_entries[] | select(.key | test("eDP")) | .key' | head -1)
    local external_display=$(echo "$outputs_json" | jq -r 'to_entries[] | select(.key | test("HDMI|DP")) | .key' | head -1)
    
    case "$choice" in
    "⊹ Laptop Only")
        notify "$APP_TITLE" "Config example:\n\noutput \"$laptop_display\" {\n    mode \"2880x1620@120\"\n    scale 1.5\n}\noutput \"$external_display\" {\n    off\n}"
        ;;
    "⊹ External Only")
        notify "$APP_TITLE" "Config example:\n\noutput \"$laptop_display\" {\n    off\n}\noutput \"$external_display\" {\n    mode \"3840x2160@60\"\n    scale 1.5\n}"
        ;;
    "⊹ Extend Right")
        notify "$APP_TITLE" "Config example:\n\noutput \"$laptop_display\" {\n    position x=0 y=0\n}\noutput \"$external_display\" {\n    position x=1920 y=0\n}"
        ;;
    "⊹ Gaming Mode")
        notify "$APP_TITLE" "Config example:\n\noutput \"$external_display\" {\n    mode \"2560x1440@120\"\n    variable-refresh-rate true\n}\noutput \"$laptop_display\" {\n    off\n}"
        ;;
    *)
        notify "$APP_TITLE" "Edit config for preset: ${choice#⊹ }"
        ;;
    esac
}

configure_vrr() {
    local outputs_json=$(get_outputs_info)
    local vrr_displays=""
    local count=0
    
    while IFS=$'\t' read -r name vrr_supported; do
        ((count++))
        local status="Not Supported"
        [[ "$vrr_supported" == "true" ]] && status="Supported"
        if [[ -n "$vrr_displays" ]]; then
            vrr_displays+="\n"
        fi
        vrr_displays+="⊹ $name [$status]"
    done < <(echo "$outputs_json" | jq -r 'to_entries[] | [.key, .value.vrr_supported // false] | @tsv')
    
    if [[ $count -eq 0 ]]; then
        notify "$APP_TITLE" "No displays found."
        return 1
    fi
    
    local selected
    selected=$(echo -e "$vrr_displays" | fuzzel --dmenu --prompt="Select Display for VRR: " -l $count) || return 0
    
    if [[ -n "$selected" ]]; then
        local display_name=$(echo "$selected" | awk '{print $2}')
        display_name=${display_name#⊹ }
        
        local vrr_options=$(
            cat <<EOF
⊹ Enable VRR
⊹ Disable VRR
⊹ On-Demand VRR
EOF
        )
        
        local choice
        choice=$(echo "$vrr_options" | fuzzel --dmenu --prompt="VRR Settings: " -l 3) || return 0
        
        case "$choice" in
        "⊹ Enable VRR")
            notify "$APP_TITLE" "Add 'variable-refresh-rate true' to $display_name in config"
            ;;
        "⊹ Disable VRR")
            notify "$APP_TITLE" "Set 'variable-refresh-rate false' for $display_name in config"
            ;;
        "⊹ On-Demand VRR")
            notify "$APP_TITLE" "Set 'variable-refresh-rate on-demand' for $display_name in config"
            ;;
        esac
    fi
}

export_configuration() {
    local outputs_json=$(get_outputs_info)
    local config_file="/tmp/niri-display-export-$(date +%Y%m%d-%H%M%S).txt"
    
    {
        echo "# Niri Display Configuration Export"
        echo "# Generated on $(date)"
        echo ""
        
        echo "$outputs_json" | jq -r 'to_entries[] | 
            "output \"\(.key)\" {\n" +
            "    mode \"\(.value.logical.width)x\(.value.logical.height)@\(((.value.modes[] | select(.is_preferred == true) | .refresh_rate) // 60000) / 1000)\"\n" +
            "    scale \(.value.logical.scale // 1.0)\n" +
            "    position x=\(.value.logical.x // 0) y=\(.value.logical.y // 0)\n" +
            (if .value.logical.transform != "Normal" then "    transform \"\(.value.logical.transform | ascii_downcase)\"\n" else "" end) +
            "}"'
    } > "$config_file"
    
    notify "$APP_TITLE" "Configuration exported to:\n$config_file"
}

# --- Main Logic ---
main() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
        -h | --help)
            echo "Usage: $(basename "$0")"
            echo "A display management utility for Niri using fuzzel."
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            exit 1
            ;;
        esac
    done
    
    # Pre-flight checks
    if ! command -v jq &>/dev/null; then
        notify "$APP_TITLE" "Error: jq is not installed."
        exit 1
    fi
    
    local main_menu_options
    main_menu_options=$(
        cat <<EOF
⊹ List Connected Displays
⊹ Configure Single Display
⊹ Apply Display Preset
⊹ Variable Refresh Rate (VRR)
⊹ Export Configuration
⊹ Reload Config
EOF
    )
    
    local num_main_options
    num_main_options=$(echo "$main_menu_options" | wc -l)
    
    local choice
    choice=$(echo "$main_menu_options" | fuzzel --dmenu --prompt="$(provide_fuzzel_prompt)" -l "$num_main_options") || exit 0
    
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
    "⊹ Export Configuration")
        export_configuration
        ;;
    "⊹ Reload Config")
        notify "$APP_TITLE" "Reloading Niri configuration..."
        niri msg reload-config
        ;;
    *)
        notify "$APP_TITLE" "Invalid option selected: $choice"
        ;;
    esac
}

# Pass all script arguments to the main function
# main "$@"
list_displays "$@"

