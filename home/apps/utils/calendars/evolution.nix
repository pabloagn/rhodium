# home/apps/utils/calendars/evolution.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.utils.calendars.evolution;
in
{
  options.rhodium.home.apps.utils.calendars.evolution = {
    enable = mkEnableOption "Evolution calendar application";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      evolution
    ];
  };
}
