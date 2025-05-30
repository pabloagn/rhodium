# ---------------------------------------------------------
# Route:............/user/desktop/hypr/hyprland.nix
# Type:.............Module
# Created by:.......Pablo Aguirre
# ---------------------------------------------------------

{ config, pkgs, ... }:

{
  # ------------------------------------------
  # Requirements
  # ------------------------------------------
  home.packages = with pkgs; [
    jq
    coreutils
    gawk
  ];

  # ------------------------------------------
  # Config Files
  # ------------------------------------------
  xdg.configFile."hypr/hyprland.conf" = {
    source = ./hyprland.conf;
  };

  # Module configurations
  xdg.configFile."hypr/modules/monitors.conf" = {
    source = ./modules/monitors.conf;
  };

  xdg.configFile."hypr/modules/keybinds.conf" = {
    source = ./modules/keybinds.conf;
  };

  xdg.configFile."hypr/modules/workspaces.conf" = {
    source = ./modules/workspaces.conf;
  };

  xdg.configFile."hypr/modules/window-rules.conf" = {
    source = ./modules/window-rules.conf;
  };

  xdg.configFile."hypr/modules/keyboard.conf" = {
    source = ./modules/keyboard.conf;
  };


}
