#!/usr/bin/env bash

# --- Main Configuration ---
APP_NAME="rhodium-displays"
APP_TITLE="Rhodium's Display Utils"
PROMPT="δ: "

# --- Imports ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -f "$SCRIPT_DIR/shared-functions.sh" ]]; then
    source "$SCRIPT_DIR/shared-functions.sh"
else
    echo "Error: shared-functions.sh not found" >&2
    exit 1
fi

# --- Helper Functions ---
get_outputs() {
    niri msg --json outputs 2>/dev/null | jq -r 'keys[]'
}

get_focused_output() {
    niri msg --json focused-output | jq -r '.name' 2>/dev/null
}

# --- Display Actions ---
show_move_workspace_menu() {
    local focused_output
    focused_output=$(get_focused_output)

    local outputs
    outputs=$(get_outputs | grep -v "^${focused_output}$")

    if [[ -z "$outputs" ]]; then
        notify "$APP_TITLE" "No other monitors available."
        return
    fi

    local target_output
    target_output=$(echo -e "$outputs" | fuzzel --dmenu --prompt="Move focused workspace to: ") || return 0

    if [[ -n "$target_output" ]]; then
        niri msg action move-workspace-to-monitor "$target_output"
        notify "$APP_TITLE" "Moved focused workspace to <span weight='bold'>$target_output</span>"
    fi
}

consolidate_workspaces_here() {
    local target_output
    target_output=$(get_focused_output)

    # Get all workspaces with their details
    local workspaces_json
    workspaces_json=$(niri msg --json workspaces)

    # Extract workspaces that are not on the target output
    local source_workspaces
    source_workspaces=$(echo "$workspaces_json" | jq -r --arg TARGET "$target_output" \
        '.[] | select(.output != $TARGET and .output != null) | .idx')

    if [[ -z "$source_workspaces" ]]; then
        notify "$APP_TITLE" "All workspaces are already on the focused monitor."
        return
    fi

    local moved_count=0
    
    # Process each workspace from other monitors
    while read -r ws_idx; do
        # First switch to the monitor that has this workspace
        local ws_output
        ws_output=$(echo "$workspaces_json" | jq -r --arg IDX "$ws_idx" '.[] | select(.idx == ($IDX | tonumber)) | .output')
        
        # Focus that monitor first
        niri msg action focus-monitor "$ws_output"
        
        # Focus the workspace
        niri msg action focus-workspace "$ws_idx"
        
        # Now move it to our target monitor
        niri msg action move-workspace-to-monitor "$target_output"
        
        ((moved_count++))
    done <<< "$source_workspaces"

    # Focus back to the target monitor
    niri msg action focus-monitor "$target_output"

    if [[ $moved_count -gt 0 ]]; then
        notify "$APP_TITLE" "Consolidated $moved_count workspace(s) to <span weight='bold'>$target_output</span>."
    fi
}

show_mirror_output_menu() {
    local outputs
    outputs=$(get_outputs)

    if [[ $(echo "$outputs" | wc -l) -lt 2 ]]; then
        notify "$APP_TITLE" "Need at least two monitors to mirror."
        return
    fi

    local source_output
    source_output=$(echo -e "$outputs" | fuzzel --dmenu --prompt="Mirror From: ") || return 0

    if [[ -z "$source_output" ]]; then return; fi

    local target_outputs
    target_outputs=$(echo -e "$outputs" | grep -v "^${source_output}$")

    local target_output
    target_output=$(echo -e "$target_outputs" | fuzzel --dmenu --prompt="Mirror To: ") || return 0

    if [[ -n "$target_output" ]]; then
        # Kill any existing wl-mirror process
        pkill wl-mirror &>/dev/null || true
        
        # Start new mirroring
        wl-mirror "$source_output" --fullscreen-output "$target_output" &
        disown
        
        notify "$APP_TITLE" "Mirroring <span weight='bold'>$source_output</span> to <span weight='bold'>$target_output</span>"
    fi
}

stop_mirroring() {
    if pkill wl-mirror &>/dev/null; then
        notify "$APP_TITLE" "Mirroring stopped."
    else
        notify "$APP_TITLE" "No mirroring process was running."
    fi
}

show_workspace_overview() {
    # Get all workspaces with detailed info
    local workspaces_json
    workspaces_json=$(niri msg --json workspaces)
    
    # Format workspace information for fuzzel menu
    local workspace_list=""
    local workspace_map=""
    
    # Group by output and format nicely
    local outputs
    outputs=$(echo "$workspaces_json" | jq -r '[.[].output] | unique | .[]')
    
    while read -r output; do
        if [[ -n "$output" ]]; then
            workspace_list+="\n$output\n"
            
            # Get workspaces for this output, sorted by index
            local ws_on_output
            ws_on_output=$(echo "$workspaces_json" | jq -r --arg OUT "$output" \
                '.[] | select(.output == $OUT) | "\(.idx)|\(.name // "Workspace " + (.idx | tostring))|\(.is_focused)|\(.active_window_id)"' | sort -n -t'|' -k1)
            
            while IFS='|' read -r idx name is_focused window_id; do
                local prefix="  "
                if [[ "$is_focused" == "true" ]]; then
                    prefix="→ "
                fi
                
                local window_info=""
                if [[ "$window_id" != "null" && -n "$window_id" ]]; then
                    window_info=" (active)"
                fi
                
                workspace_list+="${prefix}${name}${window_info}\n"
                workspace_map+="${idx}:${name}\n"
            done <<< "$ws_on_output"
        fi
    done <<< "$outputs"
    
    # Show the menu
    local selected
    selected=$(echo -e "$workspace_list" | fuzzel --dmenu --prompt="Workspaces (select to switch):" -l 20) || return 0
    
    # If a workspace was selected (not a header), switch to it
    if [[ "$selected" =~ ^[[:space:]]*(→[[:space:]])?(.+)(\s*\(active\))?$ ]]; then
        local ws_name="${BASH_REMATCH[2]}"
        
        # Find the workspace index by name
        local ws_idx
        ws_idx=$(echo "$workspaces_json" | jq -r --arg NAME "$ws_name" \
            '.[] | select(.name == $NAME or ("Workspace " + (.idx | tostring)) == $NAME) | .idx' | head -1)
        
        if [[ -n "$ws_idx" ]]; then
            niri msg action focus-workspace "$ws_idx"
        fi
    fi
}

move_all_windows_here() {
    local target_output
    target_output=$(get_focused_output)
    
    # Get current workspace index (not ID)
    local target_workspace_idx
    target_workspace_idx=$(niri msg --json workspaces | jq -r '.[] | select(.is_focused == true) | .idx')
    
    if [[ -z "$target_workspace_idx" ]]; then
        notify "$APP_TITLE" "Error: Could not determine current workspace."
        return
    fi
    
    # Get all windows with their info
    local windows_json
    windows_json=$(niri msg --json windows)
    
    # Get workspace IDs for windows to determine which aren't on current workspace
    local current_workspace_id
    current_workspace_id=$(niri msg --json workspaces | jq -r '.[] | select(.is_focused == true) | .id')
    
    # Get windows not on the current workspace
    local windows_to_move
    windows_to_move=$(echo "$windows_json" | jq -r --arg WS "$current_workspace_id" \
        '.[] | select(.workspace_id != ($WS | tonumber)) | "\(.id)|\(.title)|\(.app_id)"')
    
    if [[ -z "$windows_to_move" ]]; then
        notify "$APP_TITLE" "All windows are already on this workspace."
        return
    fi
    
    local moved_count=0
    while IFS='|' read -r window_id window_title app_id; do
        # Use the correct syntax with --id flag
        niri msg action focus-window --id "$window_id"
        
        # Move it to the current workspace using the index
        niri msg action move-window-to-workspace "$target_workspace_idx"
        
        ((moved_count++))
    done <<< "$windows_to_move"
    
    if [[ $moved_count -gt 0 ]]; then
        notify "$APP_TITLE" "Moved $moved_count window(s) to current workspace."
    fi
}

show_window_list() {
    niri msg windows
}

# --- Main Logic ---
main() {
    for cmd in niri jq fuzzel wl-mirror; do
        if ! command -v "$cmd" &>/dev/null; then
            notify "$APP_TITLE" "Error: command '$cmd' not found."
            exit 1
        fi
    done

    local main_menu_options
    main_menu_options=$(
        cat <<EOF
⊹ Move Focused Workspace to Monitor...
⊹ Consolidate All Workspaces Here
⊹ Mirror Output...
⊹ Stop Mirroring
⊹ Show Workspace Overview
⊹ Show Window List
⊹ Move All Windows to Current Workspace
EOF
    )

    local num_main_options
    num_main_options=$(echo -e "$main_menu_options" | wc -l)

    local choice
    choice=$(echo -e "$main_menu_options" | fuzzel --dmenu --prompt="$(provide_fuzzel_prompt)" -l "$num_main_options") || exit 0

    case "$choice" in
    "⊹ Move Focused Workspace to Monitor...") show_move_workspace_menu ;;
    "⊹ Consolidate All Workspaces Here") consolidate_workspaces_here ;;
    "⊹ Mirror Output...") show_mirror_output_menu ;;
    "⊹ Stop Mirroring") stop_mirroring ;;
    "⊹ Show Workspace Overview") show_workspace_overview ;;
    "⊹ Show Window List") show_window_list ;;
    "⊹ Move All Windows to Current Workspace") move_all_windows_here ;;
    *)
        notify "$APP_TITLE" "Invalid option selected: $choice"
        ;;
    esac
}

main "$@"
