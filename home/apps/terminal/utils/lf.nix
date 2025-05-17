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

  config = mkIf (config.rhodium.apps.terminal.utils.enable && cfg.enable) {
    home.packages = with pkgs; [
      lf
    ];
  };
}
