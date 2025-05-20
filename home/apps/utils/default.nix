# home/apps/utils/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.utils;
in
{
  imports = [
    ./calculators
    ./calendars
    ./notes
  ];

  options.rhodium.home.apps.utils = {
    enable = mkEnableOption "Utility applications";
  };

  config = mkIf cfg.enable {
    rhodium.home.apps.utils = {
      calendars.enable = true;
      notes.enable = true;
      calculators.enable = true;
    };
  };
}
