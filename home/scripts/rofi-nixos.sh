#!/usr/bin/env bash
# TODO: This is a mess, refactor with new approach

set -euo pipefail

nixos_menu() {
  ROFI_THEME="$HOME/.config/rofi/themes/chiaroscuro.rasi"

  # Get current directory (flake root)
  FLAKE_ROOT="$(pwd)"

  local options=(
    "⊹ Home Manager Switch user_001 <i>(Apply HM Config)</i>"
    "⊹ Home Manager Switch user_002 <i>(Apply HM Config)</i>"
    "⊹ Home Manager Build user_001 <i>(Build Only)</i>"
    "⊹ Home Manager Build user_002 <i>(Build Only)</i>"
    "⊹ NixOS Rebuild Switch host_001 <i>(Build & Switch)</i>"
    "⊹ NixOS Rebuild Switch host_002 <i>(Build & Switch)</i>"
    "⊹ NixOS Rebuild Build host_001 <i>(Build Only)</i>"
    "⊹ NixOS Rebuild Build host_002 <i>(Build Only)</i>"
    "⊹ NixOS Rebuild Test host_001 <i>(Test Config)</i>"
    "⊹ NixOS Rebuild Test host_002 <i>(Test Config)</i>"
    "⊹ Flake Update <i>(Update Inputs)</i>"
    "⊹ Flake Check <i>(Validate Config)</i>"
    "⊹ Garbage Collect <i>(Clean Store)</i>"
  )

  selected=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -P "λ " -theme "$ROFI_THEME" -markup-rows)
  [[ -z "$selected" ]] && return

  # Terminal for output
  TERM_CMD="kitty -e bash -c"

  case "$selected" in
    *"Home Manager Switch user_001"*)
      $TERM_CMD "cd '$FLAKE_ROOT' && home-manager switch --flake .#user_001; read -p 'Press Enter to close...'"
      ;;
    *"Home Manager Switch user_002"*)
      $TERM_CMD "cd '$FLAKE_ROOT' && home-manager switch --flake .#user_002; read -p 'Press Enter to close...'"
      ;;
    *"Home Manager Build user_001"*)
      $TERM_CMD "cd '$FLAKE_ROOT' && home-manager build --flake .#user_001; read -p 'Press Enter to close...'"
      ;;
    *"Home Manager Build user_002"*)
      $TERM_CMD "cd '$FLAKE_ROOT' && home-manager build --flake .#user_002; read -p 'Press Enter to close...'"
      ;;
    *"NixOS Rebuild Switch host_001"*)
      password=$(rofi -dmenu -password -P "sudo password: " -theme "$ROFI_THEME")
      [[ -z "$password" ]] && return
      $TERM_CMD "cd '$FLAKE_ROOT' && echo '$password' | sudo -S nixos-rebuild switch --flake .#host_001 --show-trace; read -p 'Press Enter to close...'"
      ;;
    *"NixOS Rebuild Switch host_002"*)
      password=$(rofi -dmenu -password -P "sudo password: " -theme "$ROFI_THEME")
      [[ -z "$password" ]] && return
      $TERM_CMD "cd '$FLAKE_ROOT' && echo '$password' | sudo -S nixos-rebuild switch --flake .#host_002 --show-trace; read -p 'Press Enter to close...'"
      ;;
    *"NixOS Rebuild Build host_001"*)
      password=$(rofi -dmenu -password -P "sudo password: " -theme "$ROFI_THEME")
      [[ -z "$password" ]] && return
      $TERM_CMD "cd '$FLAKE_ROOT' && echo '$password' | sudo -S nixos-rebuild build --flake .#host_001 --show-trace; read -p 'Press Enter to close...'"
      ;;
    *"NixOS Rebuild Build host_002"*)
      password=$(rofi -dmenu -password -P "sudo password: " -theme "$ROFI_THEME")
      [[ -z "$password" ]] && return
      $TERM_CMD "cd '$FLAKE_ROOT' && echo '$password' | sudo -S nixos-rebuild build --flake .#host_002 --show-trace; read -p 'Press Enter to close...'"
      ;;
    *"NixOS Rebuild Test host_001"*)
      password=$(rofi -dmenu -password -P "sudo password: " -theme "$ROFI_THEME")
      [[ -z "$password" ]] && return
      $TERM_CMD "cd '$FLAKE_ROOT' && echo '$password' | sudo -S nixos-rebuild test --flake .#host_001 --show-trace; read -p 'Press Enter to close...'"
      ;;
    *"NixOS Rebuild Test host_002"*)
      password=$(rofi -dmenu -password -P "sudo password: " -theme "$ROFI_THEME")
      [[ -z "$password" ]] && return
      $TERM_CMD "cd '$FLAKE_ROOT' && echo '$password' | sudo -S nixos-rebuild test --flake .#host_002 --show-trace; read -p 'Press Enter to close...'"
      ;;
    *"Flake Update"*)
      $TERM_CMD "cd '$FLAKE_ROOT' && nix flake update; read -p 'Press Enter to close...'"
      ;;
    *"Flake Check"*)
      $TERM_CMD "cd '$FLAKE_ROOT' && nix flake check; read -p 'Press Enter to close...'"
      ;;
    *"Garbage Collect"*)
      $TERM_CMD "nix-collect-garbage -d && sudo nix-collect-garbage -d; read -p 'Press Enter to close...'"
      ;;
  esac
}

nixos_menu
