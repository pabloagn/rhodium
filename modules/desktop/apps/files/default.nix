# modules/desktop/apps/files/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.desktop.apps.files;
in
{
  imports = [
    ./thunar.nix
  ];

  options.rhodium.system.desktop.apps.files = {
    enable = mkEnableOption "Files (system)";
  };

  config = mkIf cfg.enable {
  };
}
