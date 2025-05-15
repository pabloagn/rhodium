# home/desktop/launcher/rofi.nix
{ lib, config, pkgs, ... }:

with lib;
let
  # This cfg refers to config.rhodium.desktop.launcher.rofi.enable
  rofiCfg = config.rhodium.desktop.launcher.rofi;
in
{
  # This entire block is conditional on Rofi being enabled
  config = mkIf rofiCfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland; # Use rofi-wayland for Hyprland
      # You can add themes, plugins, or extra configurations here
      # For example:
      # themes = {
      #   onedark = pkgs.fetchFromGitHub {
      #     owner = "hlissner";
      #     repo = "rofi-onedark-theme";
      #     rev = "HEAD"; # or a specific commit
      #     sha256 = "0000000000000000000000000000000000000000000000000000"; # replace with actual hash
      #   };
      # };
      # extraConfig = {
      #   modi = "drun,run,window";
      #   show-icons = true;
      #   # theme = "~/.config/rofi/themes/onedark.rasi"; # If using a custom theme file
      # };
    };

    # Any Rofi-specific helper packages
    # home.packages = with pkgs; [
    #   rofi-calc
    #   rofi-emoji
    # ];
  };
}
