#!/usr/bin/env bash

# Function to handle file-based channels (open in editor)
handle_files() {
    local channel="$1"
    local selections
    selections=$(tv "$channel")
    
    if [[ -n "$selections" ]]; then
        mapfile -t file_array <<< "$selections"
        "${EDITOR:-nvim}" "${file_array[@]}"
    fi
}

# Function to handle project channels (cd to directory)
handle_projects() {
    local channel="$1"
    local selection
    selection=$(tv "$channel")
    
    if [[ -n "$selection" ]]; then
        # Get first line only for projects
        local project_dir=$(echo "$selection" | head -n1)
        if [[ -d "$project_dir" ]]; then
            cd "$project_dir" && exec "${SHELL:-bash}"
        fi
    fi
}

# Function to handle process channels (show info or kill)
handle_processes() {
    local channel="$1"
    local selections
    selections=$(tv "$channel")
    
    if [[ -n "$selections" ]]; then
        echo "$selections" | while IFS= read -r process; do
            if [[ -n "$process" ]]; then
                # Extract PID (assuming first field)
                local pid=$(echo "$process" | awk '{print $1}')
                echo "Process selected: $process"
                read -p "Kill process $pid? [y/N]: " confirm
                if [[ "$confirm" =~ ^[Yy]$ ]]; then
                    kill "$pid" 2>/dev/null || echo "Failed to kill process $pid"
                fi
            fi
        done
    fi
}

# Function to handle git channels (show info)
handle_git() {
    local channel="$1"
    local selection
    selection=$(tv "$channel")
    
    if [[ -n "$selection" ]]; then
        echo "Selected: $selection"
        case "$channel" in
            "git-branch")
                git checkout "$selection"
                ;;
            "git-diff")
                "${EDITOR:-nvim}" "$selection"
                ;;
            *)
                echo "$selection" | "${PAGER:-less}"
                ;;
        esac
    fi
}

# Function to handle docker channels
handle_docker() {
    local selections
    selections=$(tv "docker")
    
    if [[ -n "$selections" ]]; then
        echo "$selections" | while IFS= read -r container; do
            if [[ -n "$container" ]]; then
                local container_id=$(echo "$container" | awk '{print $1}')
                echo "Container: $container"
                read -p "Action [s]tart/[t]op/[r]estart/[l]ogs/[e]xec: " action
                case "$action" in
                    s) docker start "$container_id" ;;
                    t) docker stop "$container_id" ;;
                    r) docker restart "$container_id" ;;
                    l) docker logs -f "$container_id" ;;
                    e) docker exec -it "$container_id" /bin/bash ;;
                esac
            fi
        done
    fi
}

# Main function that routes to appropriate handler
main() {
    local channel="${1:-files}"
    
    case "$channel" in
        "projects")
            handle_projects "$channel"
            ;;
        "processes")
            handle_processes "$channel"
            ;;
        "docker")
            handle_docker
            ;;
        "git-"*|"git")
            handle_git "$channel"
            ;;
        *)
            handle_files "$channel"
            ;;
    esac
}

# Kill existing TV processes
if pgrep "tv" >/dev/null; then
    pkill -9 "tv"
else
    # Set terminal emulator
    TERM="${TERMINAL:-kitty}"
    # Export functions and run
    export -f handle_files handle_projects handle_processes handle_git handle_docker main
    exec "$TERM" --class television-launcher --title "Television Picker" -e bash -c "main $*"
fi
