#!/usr/bin/env bash

set -euo pipefail

ssh_menu() {
  ROFI_THEME="$HOME/.config/rofi/themes/chiaroscuro.rasi"
  
  # Define SSH connections
  local options=(
    "⊹ Connect to Alexandria <i>(Main Server)</i>"
    "⊹ Connect to Alexandria (Root) <i>(Admin Access)</i>"
    "⊹ SFTP to Alexandria <i>(File Transfer)</i>"
    "⊹ SSH Tunnel to Alexandria <i>(Port Forward)</i>"
    "⊹ Mount Alexandria via SSHFS <i>(Remote Filesystem)</i>"
    "⊹ Check Alexandria Status <i>(Ping Test)</i>"
  )
  
  selected=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -P "λ " -theme "$ROFI_THEME" -markup-rows)
  [[ -z "$selected" ]] && return
  
  # Terminal for SSH sessions
  TERM_CMD="kitty -e"
  
  case "$selected" in
    *"Connect to Alexandria (Root)"*)
      $TERM_CMD ssh root@alexandria
      ;;
    *"Connect to Alexandria"*)
      $TERM_CMD ssh alexandria
      ;;
    *"SFTP to Alexandria"*)
      $TERM_CMD sftp alexandria
      ;;
    *"SSH Tunnel to Alexandria"*)
      # Get port for tunnel
      port=$(rofi -dmenu -P "Local port: " -theme "$ROFI_THEME")
      [[ -z "$port" ]] && return
      remote_port=$(rofi -dmenu -P "Remote port: " -theme "$ROFI_THEME")
      [[ -z "$remote_port" ]] && return
      
      $TERM_CMD ssh -L "$port:localhost:$remote_port" alexandria
      notify-send "SSH" "Tunnel created: localhost:$port -> alexandria:$remote_port"
      ;;
    *"Mount Alexandria via SSHFS"*)
      # Create mount point if it doesn't exist
      mount_point="$HOME/mnt/alexandria"
      mkdir -p "$mount_point"
      
      # Check if already mounted
      if mountpoint -q "$mount_point"; then
        # Unmount
        fusermount -u "$mount_point"
        notify-send "SSHFS" "Unmounted Alexandria from $mount_point"
      else
        # Mount
        sshfs alexandria: "$mount_point"
        notify-send "SSHFS" "Mounted Alexandria to $mount_point"
      fi
      ;;
    *"Check Alexandria Status"*)
      $TERM_CMD bash -c "ping -c 4 alexandria && echo 'Press Enter to close...' && read"
      ;;
  esac
}

ssh_menu
