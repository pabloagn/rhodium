# modules/desktop/apps/browsers/firefox.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.desktop.apps.browsers.firefox;
in
{
  options.rhodium.system.desktop.apps.browsers.firefox = {
    enable = mkEnableOption "Firefox browser (system)";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };
  };
}
