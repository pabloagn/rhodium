# home/desktop/wm/hyprland.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.desktop.wm.hyprland;

  # Waybar override for experimental features
  # waybar-experimental = pkgs.waybar.overrideAttrs (oldAttrs: {
  #   mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  # });

  hyprlandDotfilesRoot = ./hyprland;
in
{
  # TODO: Eventually we move this to options.nix
  options.rhodium.desktop.wm.hyprland = {
    enable = mkEnableOption "Rhodium's Hyprland configuration";
  };

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      hyprcursor
      hyprlock
      hyprpaper
      waybar
      # waybar-experimental
      dunst
      rofi-wayland
      fuzzel
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



    # Symlink Hyprland's configuration files
    # TODO: This is a temporary solution. Eventually we will do this declaratively.
    # NOTE: Now this is done by home manager, not our own layer.
    home.file.".config/hypr/hyprland.conf" = { source = "${hyprlandDotfilesRoot}/hyprland.conf"; };
    home.file.".config/hypr/modules/keybinds.conf" = { source = "${hyprlandDotfilesRoot}/modules/keybinds.conf"; };
    home.file.".config/hypr/modules/keyboard.conf" = { source = "${hyprlandDotfilesRoot}/modules/keyboard.conf"; };
    home.file.".config/hypr/modules/monitors.conf" = { source = "${hyprlandDotfilesRoot}/modules/monitors.conf"; };
    home.file.".config/hypr/modules/plugins.conf" = { source = "${hyprlandDotfilesRoot}/modules/plugins.conf"; };
    home.file.".config/hypr/modules/window-rules.conf" = { source = "${hyprlandDotfilesRoot}/modules/window-rules.conf"; };
    home.file.".config/hypr/modules/workspaces.conf" = { source = "${hyprlandDotfilesRoot}/modules/workspaces.conf"; };

    # Ensure necessary XDG portals are configured
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      # gtkUsePortal = true;
    };
  };
}
