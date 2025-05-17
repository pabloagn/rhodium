# home/apps/terminals/emulators/ghostty.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.terminals.emulators.ghostty;
in
{
  options.rhodium.apps.terminals.emulators.ghostty = {
    enable = mkEnableOption "Rhodium's Ghostty configuration";
  };

  config = mkIf (config.rhodium.apps.terminals.emulators.enable && cfg.enable) {
    home.packages = with pkgs; [
      ghostty
    ];
  };
}
