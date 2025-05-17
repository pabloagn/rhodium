# home/apps/utils/calendars/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.utils.calendars;
in
{
  options.rhodium.apps.utils.calendars = {
    enable = mkEnableOption "Calendar applications";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kdePackages.korganizer
      evolution
      calcurse
    ];
  };
}
