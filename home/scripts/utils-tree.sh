#!/usr/bin/env bash

print_tree() {
    local dir="${1:-.}"
    local prefix="${2:-}"
    local entries=()
    local dirs=()
    local files=()
    
    # Separate dirs and files
    while IFS= read -r entry; do
        if [[ -d "$dir/$entry" ]]; then
            dirs+=("$entry")
        else
            files+=("$entry")
        fi
    done < <(ls -1A "$dir" 2>/dev/null | grep -v '^__pycache__$')
    
    # Print directories first
    for i in "${!dirs[@]}"; do
        local name="${dirs[$i]}"
        local is_last_dir=$((i == ${#dirs[@]} - 1 && ${#files[@]} == 0))
        
        if [[ $is_last_dir == 1 ]]; then
            echo "${prefix}└─ $name"
            print_tree "$dir/$name" "${prefix}    "
        else
            echo "${prefix}├─ $name"
            print_tree "$dir/$name" "${prefix}│ . "
        fi
    done
    
    # Print files
    for i in "${!files[@]}"; do
        local name="${files[$i]}"
        local is_last=$((i == ${#files[@]} - 1))
        
        if [[ $is_last == 1 ]]; then
            echo "${prefix}└── $name"
        else
            echo "${prefix}├── $name"
        fi
    done
}

print_tree "$1"

# #!/usr/bin/env bash
#
# print_tree() {
#     local dir="${1:-.}"
#     local prefix="${2:-}"
#     local entries=()
#     local dirs=()
#     local files=()
#     
#     # Separate dirs and files
#     while IFS= read -r entry; do
#         if [[ -d "$dir/$entry" ]]; then
#             dirs+=("$entry")
#         else
#             files+=("$entry")
#         fi
#     done < <(ls -1A "$dir" 2>/dev/null | grep -v '^__pycache__$')
#     
#     # Print directories first
#     for i in "${!dirs[@]}"; do
#         local name="${dirs[$i]}"
#         local is_last_dir=$((i == ${#dirs[@]} - 1 && ${#files[@]} == 0))
#         
#         if [[ $is_last_dir == 1 ]]; then
#             echo "${prefix}└─ $name"
#             print_tree "$dir/$name" "${prefix}    "
#         else
#             echo "${prefix}├─ $name"
#             print_tree "$dir/$name" "${prefix}│ . "
#         fi
#     done
#     
#     # Print files
#     for i in "${!files[@]}"; do
#         local name="${files[$i]}"
#         local is_last=$((i == ${#files[@]} - 1))
#         
#         if [[ $is_last == 1 ]]; then
#             echo "${prefix}└── $name"
#         else
#             echo "${prefix}├── $name"
#         fi
#     done
# }
#
# print_tree "$1"
