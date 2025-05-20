# home/apps/browsers/chromium.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.browsers.chromium;
in
{
  options.rhodium.home.apps.browsers.chromium = {
    enable = mkEnableOption "Chromium";
  };

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.chromium;
    };
  };
}
