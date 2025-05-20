# modules/desktop/apps/terminal/emulators/ghostty.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.desktop.apps.terminal.emulators.ghostty;
in
{
  options.rhodium.system.desktop.apps.terminal.emulators.ghostty = {
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
  };
}
