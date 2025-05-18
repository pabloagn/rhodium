# home/desktop/launcher/rofi.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.desktop.launcher.rofi;
in
{
  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      # font = "Iosevka Nerd Font 10";
      font = "JetBrainsMono Nerd Font 11";
      theme = ./rofi/themes/phantom.rasi;
    };
  };
}
