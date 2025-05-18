# home/apps/terminal/utils/lf.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.terminal.utils.lf;
in
{
  options.rhodium.apps.terminal.utils.lf = {
    enable = mkEnableOption "Rhodium's LF configuration";
  };

  config = mkIf cfg.enable {
    programs.lf = {
      enable = true;
      package = pkgs.lf;
    };
    xdg.configFile."lf/lfrc" = {
      source = ./lf/lfrc;
    };

    xdg.configFile."lf/colors" = {
      source = ./lf/colors;
    };

    xdg.configFile."lf/cleaner" = {
      source = ./lf/cleaner;
    };

    xdg.configFile."lf/previewer" = {
      source = ./lf/previewer;
    };

    xdg.configFile."lf/icons" = {
      enable = config.programs.lf.enable;
      source = ./lf/icons;
    };
  };
}
