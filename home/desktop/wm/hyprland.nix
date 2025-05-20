# home/desktop/wm/hyprland.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.desktop.wm.hyprland;

  hyprlandConfig = ./hyprland;
  hyprlandConfigModules = hyprlandConfig + "/modules";
in
{
  options.rhodium.home.desktop.wm.hyprland = {
    enable = mkEnableOption "Rhodium's Hyprland configuration";
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      hyprlock
      hyprpaper
      dunst
      libnotify
      wl-clipboard
      grim
      slurp
      cliphist
      playerctl
      jq
      coreutils
      gawk
      xdg-desktop-portal-hyprland
    ];

    # Home-manager module for Hyprland for better integration
    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;
      xwayland.enable = true;
    };

    xdg.configFile = {
      "hypr/hyprland.conf" = {
        source = "${hyprlandConfig}/hyprland.conf";
      };
      "hypr/modules/keybinds.conf" = {
        source = "${hyprlandConfigModules}/keybinds.conf";
      };
      "hypr/modules/keyboard.conf" = {
        source = "${hyprlandConfigModules}/keyboard.conf";
      };
      "hypr/modules/monitors.conf" = {
        source = "${hyprlandConfigModules}/monitors.conf";
      };
      "hypr/modules/plugins.conf" = {
        source = "${hyprlandConfigModules}/plugins.conf";
      };
      "hypr/modules/window-rules.conf" = {
        source = "${hyprlandConfigModules}/window-rules.conf";
      };
      "hypr/modules/workspaces.conf" = {
        source = "${hyprlandConfigModules}/workspaces.conf";
      };
    };

    # Ensure necessary XDG portals are configured
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      # gtkUsePortal = true;
    };
  };
}
