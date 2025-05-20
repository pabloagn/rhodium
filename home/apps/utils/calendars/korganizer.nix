# home/apps/utils/calendars/korganizer.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.utils.calendars.korganizer;
in
{
  options.rhodium.home.apps.utils.calendars.korganizer = {
    enable = mkEnableOption "KOrganizer calendar application";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kdePackages.korganizer
    ];
  };
}
