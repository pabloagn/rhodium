# modules/desktop/apps/files/thunar.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.desktop.apps.files.thunar;
in
{
  options.rhodium.system.desktop.apps.files.thunar = {
    enable = mkEnableOption "Thunar file manager (system)";
  };

  config = mkIf cfg.enable {
    programs.thunar = {
      enable = true;
    };
  };
}
