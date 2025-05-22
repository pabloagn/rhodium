# home/apps/terminal/utils/navigation/lf.nix

{ config, lib, pkgs, rhodium, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.terminal.utils.navigation.lf;
  parentCfg = config.rhodium.home.apps.terminal.utils.navigation;
in
{
  options.rhodium.home.apps.terminal.utils.navigation.lf = {
    enable = mkEnableOption "Rhodium's LF configuration" // { default = false; };
  };

  config = rhodium.lib.mkChildConfig parentCfg cfg {
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
