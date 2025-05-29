{ lib, config, userPreferences, userExtras, ... }:

let
  # Browser with personal profile
  personalProfile = userPreferences.profiles.firefox.personal or null;
  browserPersonal = if personalProfile != null
    then "firefox -P ${personalProfile}"
    else "firefox";

  # User Preferences
  knobIncrement = userPreferences.behaviour.knobIncrement;
  wallpaperTheme = userPreferences.theme.wallpaper or "dante";

  # Apps from preferences
  terminal = userPreferences.apps.terminal;
  editor = userPreferences.apps.editor;
  fileManager = "thunar";

  editorNvim = "${terminal} --directory ${config.home.homeDirectory} ${editor}";
  wallpapersPath = "${config.xdg.dataHome}/wallpapers/${wallpaperTheme}";
  appsLauncher = "raffi";

  # Utils
  utilsScreenshot = "${config.home.sessionVariables.XDG_BIN_HOME}/utils-screenshot.sh";

  # Wallpapers - Fixed to use consistent path
  mkWallpaper = num: "hyprctl hyprpaper wallpaper eDP-1,${wallpapersPath}/wallpaper-${lib.strings.fixedWidthNumber 2 num}.jpg";

  # Special Workspaces
  sw1 = "pgrep qalculate-gtk && hyprctl dispatch togglespecialworkspace calculator || qalculate-gtk";

  # Main Mod
  mainMod = "SUPER";

  # Workspace binds generation
  mkWorkspaceBinds = lib.genList
    (i:
      let n = toString (if i == 9 then 0 else i + 1); ws = toString (i + 1);
      in [
        "${mainMod}, ${n}, workspace, ${ws}"
        "${mainMod}, SHIFT, ${n}, movetoworkspace, ${ws}"
      ]
    ) 10;
in
{
  bind = lib.flatten [
    # Base Keybindings
    "${mainMod}, W, exec, ${terminal}"

    # Killers
    "${mainMod}, C, killactive" # Polite
    "${mainMod} SHIFT, C, exec, hyprctl dispatch killactive" # Force kill
    "${mainMod} CTRL, C, exec, pkill -9 $(hyprctl activewindow -j | jq -r '.pid')" # Kill process

    "${mainMod}, B, exec, ${browserPersonal}" # Launch browser on personal profile
    "${mainMod}, F, exec, ${fileManager}" # Launch file manager
    "${mainMod}, D, exec, ${editorNvim}" # Launch editor
    "${mainMod}, V, togglefloating"
    "${mainMod}, J, togglesplit"

    "${mainMod}, Q, exec, ${sw1}"

    "${mainMod}, left, movefocus, l"
    "${mainMod}, right, movefocus, r"
    "${mainMod}, up, movefocus, u"
    "${mainMod}, down, movefocus, d"

    # Generate workspace binds
    mkWorkspaceBinds

    "${mainMod}, SHIFT, right, workspace, e+1"
    "${mainMod}, SHIFT, left, workspace, e-1"

    "${mainMod}, A, exec, ${appsLauncher}"
    "${mainMod}, escape, exec, killall rofi"

    # Generate wallpaper binds (same range as hyprpaper preload)
    (lib.genList (i: "${mainMod}, ALT, ${toString (i + 1)}, exec, ${mkWallpaper (i + 1)}") 6)

    "${mainMod}, S, exec, ${utilsScreenshot}"
  ];

  bindm = [
    "${mainMod}, mouse:272, movewindow"
    "${mainMod}, mouse:273, resizewindow"
  ];

  bindl = [
    "${mainMod}, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    "${mainMod}, XF86AudioPlay, exec, playerctl play-pause"
    "${mainMod}, XF86AudioNext, exec, playerctl next"
    "${mainMod}, XF86AudioPrev, exec, playerctl previous"
  ];

  bindel = [
    "${mainMod}, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ ${knobIncrement}-"
    "${mainMod}, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ ${knobIncrement}+"
    "${mainMod}, XF86MonBrightnessDown, exec, brightnessctl set ${knobIncrement}-"
    "${mainMod}, XF86MonBrightnessUp, exec, brightnessctl set ${knobIncrement}+"
  ];
}
