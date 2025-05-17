# home/apps/terminals/emulators/wezterm.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.terminals.emulators.wezterm;
in
{
  options.rhodium.apps.terminals.emulators.wezterm = {
    enable = mkEnableOption "Rhodium's Wezterm configuration";
  };

  config = mkIf (config.rhodium.apps.terminals.emulators.enable && cfg.enable) {
    home.packages = with pkgs; [
      wezterm
    ];
  };
}
