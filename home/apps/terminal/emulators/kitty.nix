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

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
    };

    xdg.configFile."kitty/kitty.conf" = {
      source = ./kitty/kitty.conf;
    };

    xdg.configFile."kitty/themes/catppuccin-mocha.conf" = {
      source = ./kitty/themes/catppuccin-mocha.conf;
    };
  };
}
