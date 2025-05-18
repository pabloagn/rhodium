# home/apps/utils/calendars/evolution.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.utils.calendars.evolution;
in
{
  options.rhodium.apps.utils.calendars.evolution = {
    enable = mkEnableOption "Evolution calendar application";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      evolution
    ];
  };
}
