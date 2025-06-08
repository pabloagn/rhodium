#!/usr/bin/env bash

set -euo pipefail

wallpaper_menu() {
  ROFI_THEME="$HOME/.config/rofi/themes/chiaroscuro.rasi"

  # Get preloaded wallpapers from hyprpaper
  mapfile -t preloaded_wallpapers < <(hyprctl hyprpaper listloaded 2>/dev/null | grep -E '^\s*/' | sed 's/^[[:space:]]*//' || echo "")

  # If no preloaded wallpapers, scan common wallpaper directories
  if [[ ${#preloaded_wallpapers[@]} -eq 0 || "${preloaded_wallpapers[0]}" == "" ]]; then
    WALLPAPER_DIRS=(
      "$HOME/.local/share/wallpapers"
      "$HOME/Pictures/wallpapers"
      "$HOME/wallpapers"
      "/run/current-system/sw/share/pixmaps"
    )

    local found_wallpapers=()
    for dir in "${WALLPAPER_DIRS[@]}"; do
      if [[ -d "$dir" ]]; then
        while IFS= read -r -d '' file; do
          found_wallpapers+=("$file")
        done < <(find "$dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print0 2>/dev/null)
      fi
    done
    preloaded_wallpapers=("${found_wallpapers[@]}")
  fi

  [[ ${#preloaded_wallpapers[@]} -eq 0 ]] && { notify-send "Wallpaper" "No wallpapers found"; return; }

  # Get current wallpapers for each monitor
  mapfile -t monitors < <(hyprctl monitors -j | jq -r '.[].name' 2>/dev/null || hyprctl monitors | grep "Monitor" | awk '{print $2}')

  local options=()

  # Add options to set wallpaper on specific monitors
  for wallpaper in "${preloaded_wallpapers[@]}"; do
    [[ -z "$wallpaper" ]] && continue
    wallpaper_name=$(basename "$wallpaper" | sed 's/\.[^.]*$//')

    # Add option to set on all monitors
    options+=("⊹ Set $wallpaper_name <i>(All Monitors)</i>")

    # Add options for individual monitors
    for monitor in "${monitors[@]}"; do
      [[ -z "$monitor" ]] && continue
      options+=("⊹ Set $wallpaper_name on $monitor <i>(Single Monitor)</i>")
    done
  done

  # Add management options
  options+=("⊹ Preload New Wallpaper <i>(Add to Memory)</i>")
  options+=("⊹ Unload All Wallpapers <i>(Clear Memory)</i>")
  options+=("⊹ Random Wallpaper <i>(Surprise Me)</i>")

  [[ ${#options[@]} -eq 0 ]] && options+=("⊹ No Wallpapers Available <i>(Check Config)</i>")

  selected=$(printf '%s\n' "${options[@]}" | rofi -dmenu -i -P "λ " -theme "$ROFI_THEME" -markup-rows)
  [[ -z "$selected" ]] && return

  case "$selected" in
    *"Set "*)
      if [[ "$selected" =~ "All Monitors" ]]; then
        wallpaper_name=$(echo "$selected" | sed 's/⊹ Set \(.*\) <i>(All Monitors)<\/i>/\1/')
        wallpaper_path=""

        # Find full path
        for wp in "${preloaded_wallpapers[@]}"; do
          if [[ "$(basename "$wp" | sed 's/\.[^.]*$//')" == "$wallpaper_name" ]]; then
            wallpaper_path="$wp"
            break
          fi
        done

        [[ -z "$wallpaper_path" ]] && return

        # Set on all monitors
        for monitor in "${monitors[@]}"; do
          [[ -z "$monitor" ]] && continue
          hyprctl hyprpaper wallpaper "$monitor,$wallpaper_path"
        done
        notify-send "Wallpaper" "Set $wallpaper_name on all monitors"

      elif [[ "$selected" =~ "on " ]]; then
        wallpaper_name=$(echo "$selected" | sed 's/⊹ Set \(.*\) on \(.*\) <i>.*/\1/')
        monitor_name=$(echo "$selected" | sed 's/⊹ Set \(.*\) on \(.*\) <i>.*/\2/')
        wallpaper_path=""

        # Find full path
        for wp in "${preloaded_wallpapers[@]}"; do
          if [[ "$(basename "$wp" | sed 's/\.[^.]*$//')" == "$wallpaper_name" ]]; then
            wallpaper_path="$wp"
            break
          fi
        done

        [[ -z "$wallpaper_path" ]] && return

        hyprctl hyprpaper wallpaper "$monitor_name,$wallpaper_path"
        notify-send "Wallpaper" "Set $wallpaper_name on $monitor_name"
      fi
      ;;
    *"Preload New Wallpaper"*)
      # File picker for new wallpaper
      new_wallpaper=$(find "$HOME" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) 2>/dev/null | rofi -dmenu -i -P "Select wallpaper: " -theme "$ROFI_THEME")
      [[ -z "$new_wallpaper" ]] && return

      hyprctl hyprpaper preload "$new_wallpaper"
      notify-send "Wallpaper" "Preloaded $(basename "$new_wallpaper")"
      ;;
    *"Unload All Wallpapers"*)
      for wallpaper in "${preloaded_wallpapers[@]}"; do
        [[ -z "$wallpaper" ]] && continue
        hyprctl hyprpaper unload "$wallpaper"
      done
      notify-send "Wallpaper" "Unloaded all wallpapers"
      ;;
    *"Random Wallpaper"*)
      [[ ${#preloaded_wallpapers[@]} -eq 0 ]] && return
      random_wallpaper="${preloaded_wallpapers[$((RANDOM % ${#preloaded_wallpapers[@]}))]}"

      for monitor in "${monitors[@]}"; do
        [[ -z "$monitor" ]] && continue
        hyprctl hyprpaper wallpaper "$monitor,$random_wallpaper"
      done
      notify-send "Wallpaper" "Set random wallpaper: $(basename "$random_wallpaper")"
      ;;
  esac
}

wallpaper_menu
