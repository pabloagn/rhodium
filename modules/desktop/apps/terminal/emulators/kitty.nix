# modules/desktop/apps/terminal/kitty.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.desktop.apps.terminal.emulators.kitty;
in
{
  options.rhodium.system.desktop.apps.terminal.emulators.kitty = {
    enable = mkEnableOption "Rhodium's Kitty configuration";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      package = pkgs.kitty;
    };
  };
}
