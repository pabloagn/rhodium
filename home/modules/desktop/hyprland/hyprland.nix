# home/modules/desktop/hyprland/hyprland.nix

{ config, pkgs, lib, ... }:
let
  # TODO: Clean this up
  assetsDir = ../../../../assets;
  hyprModulesDir = ./modules;
  hyprConfigFiles = {
    "hypr/hyprland.conf" = ./hyprland.conf;
    "hypr/modules/monitors.conf" = ./${hyprModulesDir}/monitors.conf;
    "hypr/modules/keybinds.conf" = ./${hyprModulesDir}/keybinds.conf;
    "hypr/modules/workspaces.conf" = ./${hyprModulesDir}/workspaces.conf;
    "hypr/modules/window-rules.conf" = ./${hyprModulesDir}/window-rules.conf;
    "hypr/modules/keyboard.conf" = ./${hyprModulesDir}/keyboard.conf;
    "hypr/assets/sounds/sutter-play.ogg" = ./${assetsDir}/sounds/camera-shutter.ogg;
    "hypr/hyprpaper.conf" = ./${assetsDir}/hyprpaper/hyprpaper.conf;
  };

in

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    # Option 1: Inline settings
    # settings = {
    #   monitor = ",preferred,auto,1";
    #   exec-once = [
    #     "waybar"
    #     "dunst"
    #     "hyprpaper # if you use hyprpaper"
    #     # "blueman-applet"
    #     # "nm-applet --indicator"
    #   ];
    #   # ... other hyprland settings ...
    #   bind = [
    #     "SUPER, Q, killactive,"
    #     "SUPER, M, exit,"
    #     # ... more keybindings
    #   ];
    # };

    # TODO: Temporary config file
    configFile = ./hyprland.conf;
  };

  # Packages related to Hyprland that the user will need/want
  home.packages = with pkgs; [
    hyprpaper
    rofi-wayland
    fuzzel
    wl-clipboard
    coreutils
    gawk
    waybar
    dunst
    libnotify
    hyprcursor
  ];

  xdg.configFile = lib.mapAttrs'
    (
      destinationPath: sourcePath:
        {
          name = destinationPath;
          value = { source = sourcePath; };
        }
    )
    hyprConfigFiles;
}
