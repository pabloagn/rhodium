#!/usr/bin/env bash

# ---------------------------------------------------------
# Route:............/user/desktop/rofi/scripts/commands.sh
# Type:.............Script
# Created by:.......Pablo Aguirre
# ---------------------------------------------------------

# Rofi menu to display and copy frequently used custom commands.

# --- Configuration ---
# Define commands: Display Name ::: Description ::: Actual Command To Copy
# Use ':::' as a unique separator. Ensure it's not part of your commands.
COMMANDS=$(cat <<EOF
Update System ::: Update Flakes & Rebuild NixOS/HM ::: sudo nixos-rebuild switch --flake ~/.dotfiles/#nixos && home-manager switch --flake ~/.dotfiles/#pabloagn
Git Commit Dotfiles ::: Add all & commit dotfiles (edit msg) ::: (cd ~/.dotfiles && git add . && git commit -v)
Find Nix Pkg Definition ::: Find package definition in config (append pkg name) ::: findpkg 
Edit Neovim Config ::: Open Neovim config folder in Kitty ::: kitty nvim ~/.config/nvim
Restart Waybar ::: Kill and restart Waybar ::: killall waybar && sleep 1 && waybar
Toggle Mic Mute ::: Mute/Unmute default source ::: wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
Select Audio Sink ::: Rofi menu for Pipewire sinks ::: pw-select-node -t sink
Select Audio Source ::: Rofi menu for Pipewire sources ::: pw-select-node -t source
EOF
# --- Add more commands above ---
)

# Rofi Theme (ensure this path is correct)
ROFI_THEME="/home/pabloagn/.dotfiles/user/desktop/rofi/themes/style-4.rasi"
# --- End Configuration ---

# Check dependency: wl-copy (from wl-clipboard package)
if ! command -v wl-copy &> /dev/null; then
    notify-send -u critical "Rofi Commands Error" "'wl-copy' not found. Please install 'wl-clipboard'."
    exit 1
fi

# Format the list for Rofi display (Name ::: Description)
# Using awk for reliable field splitting with the custom delimiter ' ::: '
DISPLAY_LIST=$(echo "$COMMANDS" | awk -F ' ::: ' '{gsub(/^[ \t]+|[ \t]+$/, "", $1); gsub(/^[ \t]+|[ \t]+$/, "", $2); print $1 " ::: " $2}')

# Display Rofi menu
# -dmenu: Run in dmenu mode (reads from stdin)
# -i: Case-insensitive search
# -p: Prompt text
# -markup-rows: (Optional) Allows basic Pango markup in display names if needed
# -theme: Apply your theme
SELECTION=$(echo -e "$DISPLAY_LIST" | rofi -dmenu -i -p "Copy Command:" -theme "$ROFI_THEME")

# Exit if Rofi was cancelled (e.g., Esc pressed)
if [ -z "$SELECTION" ]; then
    exit 0
fi

# Extract the selected display name part (used for matching)
SELECTED_NAME=$(echo "$SELECTION" | awk -F ' ::: ' '{gsub(/^[ \t]+|[ \t]+$/, "", $1); print $1}')

# Find the full original line matching the selected display name
# Using grep with -F for fixed string matching on the name part is safer
# Need to escape potential regex characters in SELECTED_NAME if not using -F, but awk is better here.
# Using awk again for reliable field extraction based on the unique name
ACTUAL_COMMAND=$(echo "$COMMANDS" | awk -F ' ::: ' -v name="$SELECTED_NAME" '{gsub(/^[ \t]+|[ \t]+$/, "", $1); if ($1 == name) {print $3; exit}}')

# Copy the extracted command to the Wayland clipboard
if [ -n "$ACTUAL_COMMAND" ]; then
    echo -n "$ACTUAL_COMMAND" | wl-copy
    # Notify the user
    notify-send "Command Copied" "'${SELECTED_NAME}' copied to clipboard."
else
    notify-send -u critical "Rofi Commands Error" "Could not find command for selection: $SELECTION"
    exit 1
fi

exit 0
