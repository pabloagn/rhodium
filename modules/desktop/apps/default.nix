# modules/desktop/apps/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.desktop.apps;
in
{
  imports = [
    ./browsers
    ./files
    ./terminal
  ];

  options.rhodium.system.desktop.apps = {
    enable = mkEnableOption "Rhodium's desktop apps configuration";
  };

  config = mkIf cfg.enable {
    rhodium.system.desktop.apps = {
      browsers.enable = true;
      files.enable = true;
      terminal.enable = true;
    };
  };
}
