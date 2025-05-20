# home/apps/utils/calendars/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.utils.calendars;
in
{
  imports = [
    ./korganizer.nix
    ./evolution.nix
    ./calcurse.nix
  ];

  options.rhodium.home.apps.utils.calendars = {
    enable = mkEnableOption "Calendar applications";
  };

  config = mkIf cfg.enable {
    rhodium.home.apps.utils.calendars = {
      korganizer.enable = true;
      evolution.enable = false;
      calcurse.enable = false;
    };
  };
}
