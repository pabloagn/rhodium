#!/usr/bin/env bash

# Find all TODO entries and format for fzf
rg --line-number --no-heading "TODO:" | while IFS=':' read -r file line_num todo_line; do
    # Get context lines using sd for trimming whitespace
    prev_line=$(sd '^[[:space:]]*' '' <<< "$(sed -n "$((line_num - 1))p" "$file" 2>/dev/null)")
    current_line=$(sd '^[[:space:]]*' '' <<< "$todo_line")
    next_line=$(sd '^[[:space:]]*' '' <<< "$(sed -n "$((line_num + 1))p" "$file" 2>/dev/null)")
    
    # Format output with indentation
    printf "%s\n" "$file"
    printf "  %s\n" "${prev_line:-}"
    printf "  %s\n" "$current_line"
    printf "  %s\n" "${next_line:-}"
    printf "\n"
done | fzf --multi \
    --preview 'file=$(echo {} | head -1); line=$(rg --line-number --no-heading "TODO:" "$file" | head -1 | cut -d: -f2); bat --style=numbers --color=always --highlight-line="$line" "$file" 2>/dev/null || cat "$file"' \
    --bind 'enter:execute(file=$(echo {} | head -1); line=$(rg --line-number --no-heading "TODO:" "$file" | head -1 | cut -d: -f2); ${EDITOR:-vim} +"$line" "$file")'
