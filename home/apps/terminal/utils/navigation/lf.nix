# home/apps/terminal/utils/navigation/lf.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.terminal.utils.navigation.lf;
in
{
  options.rhodium.home.apps.terminal.utils.navigation.lf = {
    enable = mkEnableOption "Rhodium's LF configuration";
  };

  config = mkIf cfg.enable {
    programs.lf = {
      enable = true;
      package = pkgs.lf;
    };

    xdg.configFile = {
      "lf/lfrc" = {
        source = ./lf/lfrc;
      };

      "lf/colors" = {
        source = ./lf/colors;
      };

      "lf/cleaner" = {
        source = ./lf/cleaner;
      };

      "lf/previewer" = {
        source = ./lf/previewer;
      };

      "lf/icons" = {
        enable = true;
        source = ./lf/icons;
      };
    };
  };
}
