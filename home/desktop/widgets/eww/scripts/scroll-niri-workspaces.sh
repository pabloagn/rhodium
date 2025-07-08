#!/usr/bin/env bash
set -euo pipefail

direction="$1"

# Get raw workspaces sorted by their Niri index (1, 2, 3...)
raw_workspaces=$(niri msg --json workspaces | jq -c 'sort_by(.idx)')

# Extract IDs and current focused ID
workspace_ids=($(echo "$raw_workspaces" | jq -r '.[].id'))
focused_id=$(echo "$raw_workspaces" | jq -r '.[] | select(.is_focused) | .id')

# Exit if no workspace is focused or list is empty
if [[ -z "$focused_id" || "$raw_workspaces" == "[]" ]]; then
    exit 0
fi

num_workspaces=${#workspace_ids[@]}
current_idx=-1

# Find the array index of the currently focused workspace
for i in "${!workspace_ids[@]}"; do
    if [[ "${workspace_ids[$i]}" == "$focused_id" ]]; then
        current_idx=$i
        break
    fi
done

# Exit if focused workspace not found (shouldn't happen with consistent IPC)
if [[ "$current_idx" == -1 ]]; then
    exit 0
fi

next_idx=$current_idx

if [[ "$direction" == "up" ]]; then
    # Move to previous workspace (cyclically)
    next_idx=$(( (current_idx - 1 + num_workspaces) % num_workspaces ))
elif [[ "$direction" == "down" ]]; then
    # Move to next workspace (cyclically)
    next_idx=$(( (current_idx + 1) % num_workspaces ))
else
    exit 1 # Invalid direction argument
fi

next_workspace_id="${workspace_ids[$next_idx]}"

niri msg action focus-workspace --id "$next_workspace_id"
