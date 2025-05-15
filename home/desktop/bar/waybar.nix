# home/desktop/bar/waybar.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.desktop.bar.waybar;
  waybarUserConfigDir = ./config;
in
{
  # Options specific to this Waybar module
  options.rhodium.desktop.bar.waybar = {
    enable = mkEnableOption "Rhodium's Waybar configuration";
  };

  # Configuration applied if rhodium.desktop.bar.waybar.enable is true
  config = mkIf cfg.enable {
    home.packages = [ pkgs.waybar ];

    home.file.".config/waybar/config.jsonc" = { source = "${waybarUserConfigDir}/config.jsonc"; };
    home.file.".config/waybar/style.css" = { source = "${waybarUserConfigDir}/style.css"; };
  };
}
