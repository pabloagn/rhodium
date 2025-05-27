{ lib, config, pkgs, ... }:

let
  # Objects
  preferredApps = config.preferredApps;
  preferredWallpapers = "dante"; # TODO: Eventually we use this as part of the theme.

  # Variables
  terminal = preferredApps.terminal;
  browser = preferredApps.browser;
  fileManager = "thunar";
  # editorCode = "codium";
  editorNvim = "${preferredApps.terminal} --directory ${config.home.homeDirectory} ${preferredApps.editor}";
  wallpapers = "${config.home.XDG_DATA_HOME}/wallpapers/${preferredWallpapers}";

  # Rofi Menus
  rofiApps = "rofi -show drun -theme ${config.home.homeDirectory}/rofi/themes/phantom.rasi";
  # rofiAliases = "${config.home.sessionVariables.XDG_BIN_HOME}/rofi-aliases.sh";
  rofiFuzzySearch = "${config.home.sessionVariables.XDG_BIN_HOME}/rofi-fuzzy-search.sh";
  rofiEmojis = "${config.home.sessionVariables.XDG_BIN_HOME}/rofi-dmenu-emoji.sh";
  # rofiExecutables = "${config.home.sessionVariables.XDG_BIN_HOME}/rofi-dmenu-executables.sh";
  rofiCommands = "${config.home.sessionVariables.XDG_BIN_HOME}/rofi-commands.sh";
  # rofiFuzzyFinder = "${config.home.sessionVariables.XDG_BIN_HOME}/rofi-fuzzy-finder.sh";

  # Utils
  utilsScreenshot = "${config.home.sessionVariables.XDG_BIN_HOME}/utils-screenshot.sh";

  # Wallpaper Setting (Manual Overrides)
  wl1 = "hyprctl hyprpaper wallpaper eDP-1,${wallpapers}/wallpaper-01.jpg";
  wl2 = "hyprctl hyprpaper wallpaper eDP-1,${wallpapers}/wallpaper-02.jpg";
  wl3 = "hyprctl hyprpaper wallpaper eDP-1,${wallpapers}/wallpaper-03.jpg";
  wl4 = "hyprctl hyprpaper wallpaper eDP-1,${wallpapers}/wallpaper-04.jpg";
  wl5 = "hyprctl hyprpaper wallpaper eDP-1,${wallpapers}/wallpaper-05.jpg";
  wl6 = "hyprctl hyprpaper wallpaper eDP-1,${wallpapers}/wallpaper-06.jpg";

  # Special Workspaces
  sw1 = "pgrep qalculate-gtk && hyprctl dispatch togglespecialworkspace calculator || qalculate-gtk";

  # Main Mod
  mainMod = "SUPER";

  # Extras
  knobPerc = "5%";
in
{
  bind = [
    # Base Keybindings
    "${mainMod}, W, exec, ${terminal}"
    "${mainMod}, C, killactive"
    "${mainMod}, B, exec, ${browser}"
    "${mainMod}, F, exec, ${fileManager}"
    "${mainMod}, D, exec, ${editorNvim}"
    "${mainMod}, V, togglefloating"
    "${mainMod}, J, togglesplit"

    # Special Workspaces
    "${mainMod}, Q, exec, ${sw1}"

    # Window Navigation & Manipulation
    "${mainMod}, left, movefocus, l"
    "${mainMod}, right, movefocus, r"
    "${mainMod}, up, movefocus, u"
    "${mainMod}, down, movefocus, d"

    # Workspace Navigation
    "${mainMod}, 1, workspace, 1"
    "${mainMod}, 2, workspace, 2"
    "${mainMod}, 3, workspace, 3"
    "${mainMod}, 4, workspace, 4"
    "${mainMod}, 5, workspace, 5"
    "${mainMod}, 6, workspace, 6"
    "${mainMod}, 7, workspace, 7"
    "${mainMod}, 8, workspace, 8"
    "${mainMod}, 9, workspace, 9"
    "${mainMod}, 0, workspace, 10"
    "${mainMod}, SHIFT, 1, movetoworkspace, 1"
    "${mainMod}, SHIFT, 2, movetoworkspace, 2"
    "${mainMod}, SHIFT, 3, movetoworkspace, 3"
    "${mainMod}, SHIFT, 4, movetoworkspace, 4"
    "${mainMod}, SHIFT, 5, movetoworkspace, 5"
    "${mainMod}, SHIFT, 6, movetoworkspace, 6"
    "${mainMod}, SHIFT, 7, movetoworkspace, 7"
    "${mainMod}, SHIFT, 8, movetoworkspace, 8"
    "${mainMod}, SHIFT, 9, movetoworkspace, 9"
    "${mainMod}, SHIFT, 0, movetoworkspace, 10"
    "${mainMod}, SHIFT, right, workspace, e+1"
    "${mainMod}, SHIFT, left, workspace, e-1"

    # Rofi Menus
    "${mainMod}, A, exec, ${rofiApps}"
    "${mainMod}, E, exec, ${rofiEmojis}"
    "${mainMod}, P, exec, ${rofiFuzzySearch}"
    "${mainMod}, Z, exec, ${rofiCommands}"
    "${mainMod}, escape, exec, killall rofi"

    # Wallpaper Setting
    "${mainMod}, ALT, 1, exec, ${wl1}"
    "${mainMod}, ALT, 2, exec, ${wl2}"
    "${mainMod}, ALT, 3, exec, ${wl3}"
    "${mainMod}, ALT, 4, exec, ${wl4}"
    "${mainMod}, ALT, 5, exec, ${wl5}"
    "${mainMod}, ALT, 6, exec, ${wl6}"

    # Screenshots
    "${mainMod}, S, exec, ${utilsScreenshot}"
  ];

  bindm = [
    # Window Manipulation
    "${mainMod}, mouse:272, movewindow"
    "${mainMod}, mouse:273, resizewindow"
  ];

  bindl = [
    # Media Controls
    "${mainMod}, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    "${mainMod}, XF86AudioPlay, exec, playerctl play-pause"
    "${mainMod}, XF86AudioNext, exec, playerctl next"
    "${mainMod}, XF86AudioPrev, exec, playerctl previous"
  ];

  bindel = [
    # Brightness Controls
    "${mainMod}, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ ${knobPerc}-"
    "${mainMod}, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ ${knobPerc}+"
    "${mainMod}, XF86MonBrightnessDown, exec, brightnessctl set ${knobPerc}-"
    "${mainMod}, XF86MonBrightnessUp, exec, brightnessctl set ${knobPerc}+"
  ];
}
