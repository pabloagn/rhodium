# home/apps/files/thunar.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.files.thunar;
in
{
  options.rhodium.home.apps.files.thunar = {
    enable = mkEnableOption "Thunar file manager";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xfce.thunar
    ];
  };
}
