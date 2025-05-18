# home/apps/utils/calendars/calcurse.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.utils.calendars.calcurse;
in
{
  options.rhodium.apps.utils.calendars.calcurse = {
    enable = mkEnableOption "Calcurse calendar application";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      calcurse
    ];
  };
}
