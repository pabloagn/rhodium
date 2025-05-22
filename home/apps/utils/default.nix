# home/apps/utils/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.utils;
  parentCfg = config.rhodium.home.apps;
  categoryName = "utils";
in
{
  imports = [
    ./calculators/default.nix
    ./calendars/default.nix
    ./notes/default.nix
  ];

  options.rhodium.home.apps.${categoryName} = {
    enable = mkEnableOption "Utility applications";
  };

  config = rhodium.lib.mkChildConfig parentCfg cfg {
    rhodium.home.apps.${categoryName} = {
      calendars.enable = false;
      notes.enable = false;
      calculators.enable = false;
    };
  };
}
