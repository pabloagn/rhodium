# home/apps/terminals/emulators/kitty.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.terminals.emulators.kitty;
in
{
  options.rhodium.apps.terminals.emulators.kitty = {
    enable = mkEnableOption "Rhodium's Kitty configuration";
  };

  config = mkIf (config.rhodium.apps.terminals.emulators.enable && cfg.enable) {
    home.packages = with pkgs; [
      kitty
    ];
  };
}
