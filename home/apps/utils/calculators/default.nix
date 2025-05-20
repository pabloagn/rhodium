# home/apps/utils/calculators/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.utils.calculators;
in
{
  options.rhodium.home.apps.utils.calculators = {
    enable = mkEnableOption "Calculator applications";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      qalculate-gtk
    ];
  };
}
