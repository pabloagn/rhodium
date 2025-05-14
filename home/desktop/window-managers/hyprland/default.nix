# Home Manager/desktop/window-managers/hyprland/default.nix
{ config, lib, pkgs, ... }:

let
  # Configuration directories
  modulesDir = ./modules;
  scriptsDir = ./scripts;

  # Define a map of all Hyprland configuration files
  hyprConfigFiles = {
    # Main config
    "hypr/hyprland.conf".source = ./hyprland.conf;

    # Modules
    "hypr/modules/keybinds.conf".source = ./modules/keybinds.conf;
    "hypr/modules/keyboard.conf".source = ./modules/keyboard.conf;
    "hypr/modules/monitors.conf".source = ./modules/monitors.conf;
    "hypr/modules/window-rules.conf".source = ./modules/window-rules.conf;
    "hypr/modules/workspaces.conf".source = ./modules/workspaces.conf;

    # Scripts with executable permissions
    "hypr/scripts/autostart.sh" = {
      source = ./scripts/autostart.sh;
      executable = true;
    };
    "hypr/scripts/window-switcher.sh" = {
      source = ./scripts/window-switcher.sh;
      executable = true;
    };
    "hypr/scripts/screenshot.sh" = {
      source = ./scripts/screenshot.sh;
      executable = true;
    };
    "hypr/scripts/toggle-special-workspace.sh" = {
      source = ./scripts/toggle-special-workspace.sh;
      executable = true;
    };
  };
in
{
  # Install Hyprland and essential packages
  home.packages = with pkgs; [
    waybar
    dunst
    libnotify
    hyprcursor
    rofi-wayland
    fuzzel
    hyprlock


    hyprland
    hyprpaper
    hyprpicker
    waybar
    wofi
    dunst
    swww
    wl-clipboard
    brightnessctl
    playerctl
    pamixer
    grim # screenshot utility
    slurp # area selection
  ];

  # Enable and configure Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
  };

  # Install all configuration files to the correct locations
  xdg.configFile = hyprConfigFiles;
}
