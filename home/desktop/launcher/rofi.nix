# home/desktop/launcher/rofi.nix
{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.desktop.launcher.rofi;
in
{
  # This entire block is conditional on Rofi being enabled
  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
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
