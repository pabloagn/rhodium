{
  host,
  userPreferences,
  ...
}:
let
  preferredApps = userPreferences.apps;
  preferredBehaviour = userPreferences.behaviour;
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Core
      # ----------------------------------------

      # Tier 1
      "$mainMod, W, exec, ${preferredApps.terminal}"
      "$mainMod, B, exec, ${preferredApps.browser}" # TODO: Glue to main browser profile declaratively
      "$mainMod, F, exec, ${preferredApps.terminal} -e yw"
      "$mainMod, E, exec, ${preferredApps.terminal} -e vw"
      "$mainMod, I, exec, ${preferredApps.ide}"
      "$mainMod, A, exec, ~/.local/bin/rofi-launcher.sh"
      "$mainMod, S, exec, ~/.local/bin/utils-screenshot.sh"

      # Tier 2 (Fallbacks)
      "$mainMod SHIFT, W, exec, ${preferredApps.terminalAlt}"
      "$mainMod SHIFT, B, exec, ${preferredApps.browserAlt}"
      "$mainMod SHIFT, F, exec, ${preferredApps.filesGraphic}"
      "$mainMod SHIFT, E, exec, ${preferredApps.terminal} -e ${preferredApps.editorAlt}"
      "$mainMod SHIFT, I, exec, ${preferredApps.ideAlt}"
      # "$mainMod SHIFT, A, exec, ~/.local/bin/rofi-jumper.sh"
      # "$mainMod SHIFT, S, exec, ~/.local/bin/utils-screenshot.sh --area"
      # "$mainMod SHIFT, M, exec, ~/.local/bin/utils-screenshot.sh"
      # "$mainMod SHIFT, H, exec, ~./local/bin/utils-color-picker.sh"

      # Tier 3 (Secondary menus & appearance)
      "$mainMod ALT, P, exec, ~/.local/bin/rofi-power.sh"
      "$mainMod ALT, N, exec, ~/.local/bin/rofi-nixos.sh"
      "$mainMod ALT, B, exec, ~/.local/bin/rofi-bluetooth.sh"
      "$mainMod ALT, W, exec, ~/.local/bin/rofi-wifi.sh"
      "$mainMod ALT, D, exec, ~/.local/bin/rofi-devices.sh"
      "$mainMod ALT, M, exec, ~/.local/bin/rofi-monitors.sh"
      # "$mainMod, ALT, W, exec, ~./local/bin/rofi-wallpaper.sh"
      # "$mainMod, ALT, S, exec, ~/.local/bin/utils-screenshot.sh" # Add an area arg

      # Hyprpaper
      # ----------------------------------------

      # TODO: Eventually we do this using map. For now we go for the simpler route
      "$mainMod ALT, 1, exec, hyprctl hyprpaper wallpaper ${host.mainMonitor.monitorID},~/.local/share/wallpapers/dante/wallpaper-01.jpg"
      "$mainMod ALT, 2, exec, hyprctl hyprpaper wallpaper ${host.mainMonitor.monitorID},~/.local/share/wallpapers/dante/wallpaper-02.jpg"
      "$mainMod ALT, 3, exec, hyprctl hyprpaper wallpaper ${host.mainMonitor.monitorID},~/.local/share/wallpapers/dante/wallpaper-03.jpg"
      "$mainMod ALT, 4, exec, hyprctl hyprpaper wallpaper ${host.mainMonitor.monitorID},~/.local/share/wallpapers/dante/wallpaper-04.jpg"
      "$mainMod ALT, 5, exec, hyprctl hyprpaper wallpaper ${host.mainMonitor.monitorID},~/.local/share/wallpapers/dante/wallpaper-05.jpg"

      # Special workspaces
      "$mainMod, Q, exec, pgrep qalculate-gtk && hyprctl dispatch togglespecialworkspace calculator || qalculate-gtk"
      # "$mainMod, Q, exec, pgrep qalculate-gtk && hyprctl dispatch togglespecialworkspace calculator || qalculate-gtk"

      # Cycles
      "$mainMod, Tab, exec, hyprctl dispatch focuscurrentorlast; hyprctl dispatch alterzorder top" # Prev - Current
      # "$mainMod SHIFT, Tab, layoutmsg, cyclenext" # Master - Dwindle

      # Kills
      "$mainMod, escape, exec, killall rofi" # Rofi
      "$mainMod, C, killactive" # Ask
      "$mainMod SHIFT, C, exec, hyprctl dispatch killactive" # Demand
      "$mainMod CTRL, C, exec, pkill -9 $(hyprctl activewindow -j | jq -r '.pid')" # Nuke

      # Windows
      # ----------------------------------------
      # Swaps
      # "$mainMod SHIFT, H, swapwindow, l" # Main key
      # "$mainMod SHIFT, H, moveactive, -50 0" # Fallback for floating
      # "$mainMod SHIFT, L, swapwindow, r"
      # "$mainMod SHIFT, L, moveactive, 50 0"
      # "$mainMod SHIFT, K, swapwindow, u"
      # "$mainMod SHIFT, K, moveactive, 0 -50"
      # "$mainMod SHIFT, J, swapwindow, d"
      # "$mainMod SHIFT, J, moveactive, 0 50"

      # Floating
      "$mainMod, V, togglefloating"

      # Rotate
      "$mainMod, J, togglesplit"

      # Focus
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # Workspaces
      # ----------------------------------------
      # Workspaces jump
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

      # Workspaces navigate
      "$mainMod SHIFT, right, workspace, e+1"
      "$mainMod SHIFT, left, workspace, e-1"

      # Workspaces send
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
    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    bindel = [
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ ${preferredBehaviour.knobIncrement}-"
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ ${preferredBehaviour.knobIncrement}+"
      ", XF86MonBrightnessDown, exec, brightnessctl set ${preferredBehaviour.knobIncrement}-"
      ", XF86MonBrightnessUp, exec, brightnessctl set +${preferredBehaviour.knobIncrement}"
    ];

    bindl = [
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
  };
}
