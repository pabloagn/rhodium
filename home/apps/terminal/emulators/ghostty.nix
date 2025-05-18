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

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      package = pkgs.ghostty;
    };

    xdg.configFile."ghostty/config" = {
      source = ./ghostty/config;
    };
  };
}
