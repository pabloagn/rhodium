# home/apps/terminal/utils/default.nix

{ config, lib, pkgs, rhodium,... }:

with lib;
let
  cfg = config.rhodium.home.apps.terminal.utils;
in
{
  imports = [
    ./compression
    ./development
    ./multiplexers
    ./navigation
    ./networking
    ./processing
    ./productivity
    ./system
  ];

  options.rhodium.home.apps.terminal.utils = {
    enable = mkEnableOption "Rhodium's terminal utils";
  };

  config = mkIf cfg.enable {
    rhodium.home.apps.terminal.utils = { };
  };
}
