# home/apps/utils/default.nix

{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.rhodium.apps.utils;
in
{
  imports = [
    ./calendars
    ./notes
    ./calculators
  ];

  options.rhodium.apps.utils = {
    enable = mkEnableOption "Utility applications";
  };

  config = mkIf cfg.enable {
    rhodium.apps.utils.calendars.enable = true;
    rhodium.apps.utils.notes.enable = true;
    rhodium.apps.utils.calculators.enable = true;
  };
}
