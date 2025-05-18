# home/apps/utils/calendars/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.utils.calendars;
in
{
  imports = [
    ./korganizer.nix
    ./evolution.nix
    ./calcurse.nix
  ];

  options.rhodium.apps.utils.calendars = {
    enable = mkEnableOption "Calendar applications";
  };

  config = mkIf cfg.enable {
    rhodium.apps.utils.calendars.korganizer.enable = true;
    rhodium.apps.utils.calendars.evolution.enable = true;
    rhodium.apps.utils.calendars.calcurse.enable = true;
  };
}
