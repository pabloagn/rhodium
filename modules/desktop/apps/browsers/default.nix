# modules/desktop/apps/browsers/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.desktop.apps.browsers;
in
{
  imports = [
    ./firefox.nix
  ];

  options.rhodium.system.desktop.apps.browsers = {
    enable = mkEnableOption "Browsers (system)";
  };

  config = mkIf cfg.enable {
  };
}
