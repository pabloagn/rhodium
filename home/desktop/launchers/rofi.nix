{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };

  home.file.".local/bin/window-switcher" = {
    text = ''
      #!/usr/bin/env bash

      # Premium Window Switcher with multiple modes
      MODE="''${1:-smart}"

      case "$MODE" in
        "smart")
          # Intelligent switching: if 2 windows, toggle; if more, show rofi
          WINDOW_COUNT=$(hyprctl clients -j | jq length)
          if [ "$WINDOW_COUNT" -le 2 ]; then
            hyprctl dispatch focuscurrentorlast
            hyprctl dispatch alterzorder top
          else
            ~/.local/bin/window-switcher rofi
          fi
          ;;

        "rofi")
          # Beautiful rofi window picker with thumbnails
          rofi -show window \
            -window-thumbnail \
            -window-format '{w} {c} {t}' \
            -theme ~/.config/rofi/themes/window-switcher.rasi \
            -kb-accept-entry "Return,Alt+Tab" \
            -kb-cancel "Escape,Alt+grave"
          ;;

        "cycle")
          # Cycle through windows on current workspace
          hyprctl dispatch cyclenext
          ;;

        "cycle-back")
          # Cycle backwards
          hyprctl dispatch cyclenext prev
          ;;

        "workspace")
          # Show all windows from all workspaces
          rofi -show window \
            -window-thumbnail \
            -theme ~/.config/rofi/themes/workspace-overview.rasi
          ;;

        "recent")
          # Show recently used windows (last 10)
          hyprctl clients -j | jq -r '
            sort_by(.focusHistoryID) | reverse | .[0:10] |
            .[] | "focus \(.address)"
          ' | rofi -dmenu -theme ~/.config/rofi/themes/recent-windows.rasi | \
          while read cmd addr; do
            hyprctl dispatch focuswindow "address:$addr"
          done
          ;;
      esac
    '';
    executable = true;
  };

  xdg.configFile = {
    "rofi/themes/chiaroscuro.rasi" = { source = ./rofi/themes/chiaroscuro.rasi; };
    "rofi/themes/base.rasi" = { source = ./rofi/themes/base.rasi; };
    "rofi/themes/window-switcher.rasi" = { source = ./rofi/themes/window-switcher.rasi; };
    "rofi/themes/workspace-overview.rasi" = { source = ./rofi/themes/workspace-overview.rasi; };
    "rofi/themes/recent-windows.rasi" = { source = ./rofi/themes/recent-windows.rasi; };
  };
}
