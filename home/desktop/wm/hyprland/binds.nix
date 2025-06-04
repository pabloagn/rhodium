{ config, ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind = [

      # Smart Alt+Tab: 2 windows = toggle, more = rofi picker
      # "ALT, Tab, exec, ~/.local/bin/window-switcher smart"

      # Traditional cycling (for muscle memory)
      # "ALT SHIFT, Tab, exec, ~/.local/bin/window-switcher cycle-back"

      # Power user: Super+Tab for workspace overview
      # "SUPER, Tab, exec, ~/.local/bin/window-switcher workspace"

      # Recent windows (Super+grave changed to avoid conflict)
      # "SUPER, semicolon, exec, ~/.local/bin/window-switcher recent"

      # Quick window cycling (no UI, just focus)
      # "SUPER, bracketright, exec, ~/.local/bin/window-switcher cycle"
      # "SUPER, bracketleft, exec, ~/.local/bin/window-switcher cycle-back"

      # Emergency: Force rofi picker
      # "SUPER ALT, Tab, exec, ~/.local/bin/window-switcher rofi"


      # Alt-Tab window switching
      "$mainMod, Tab, exec, hyprctl dispatch focuscurrentorlast; hyprctl dispatch alterzorder top"

      # Apps
      # ----------------------------------------
      "$mainMod, W, exec, ghostty"
      "$mainMod, B, exec, firefox"
      "$mainMod, F, exec, thunar"
      "$mainMod, D, exec, ghostty -e hx"
      "$mainMod, A, exec, ~/.local/bin/rofi-launcher.sh"

      # Rofi
      "$mainMod, escape, exec, killall rofi"

      # Kills
      # ----------------------------------------
      # Polite
      "$mainMod, C, killactive"

      # Demand
      "$mainMod SHIFT, C, exec, hyprctl dispatch killactive"

      # Enforce
      "$mainMod CTRL, C, exec, pkill -9 $(hyprctl activewindow -j | jq -r '.pid')"

      # Windows
      # ----------------------------------------
      "$mainMod, V, togglefloating"
      "$mainMod, J, togglesplit"
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # Workspaces
      # ----------------------------------------
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"
      "$mainMod SHIFT, right, workspace, e+1"
      "$mainMod SHIFT, left, workspace, e-1"
      "$mainMod, Q, exec, pgrep qalculate-gtk && hyprctl dispatch togglespecialworkspace calculator || qalculate-gtk"

      # Screenshot util
      "$mainMod, S, exec, ~/.local/bin/utils-screenshot.sh"

      # Hyprpaper
      # ----------------------------------------
      "$mainMod ALT, 1, exec, hyprctl hyprpaper wallpaper eDP-1,~/.local/share/wallpapers/dante/wallpaper-01.jpg"
      "$mainMod ALT, 2, exec, hyprctl hyprpaper wallpaper eDP-1,~/.local/share/wallpapers/dante/wallpaper-02.jpg"
      "$mainMod ALT, 3, exec, hyprctl hyprpaper wallpaper eDP-1,~/.local/share/wallpapers/dante/wallpaper-03.jpg"
      "$mainMod ALT, 4, exec, hyprctl hyprpaper wallpaper eDP-1,~/.local/share/wallpapers/dante/wallpaper-04.jpg"
      "$mainMod ALT, 5, exec, hyprctl hyprpaper wallpaper eDP-1,~/.local/share/wallpapers/dante/wallpaper-05.jpg"
      "$mainMod ALT, 6, exec, hyprctl hyprpaper wallpaper eDP-1,~/.local/share/wallpapers/dante/wallpaper-06.jpg"
    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    bindel = [
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
    ];

    bindl = [
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
  };
}
