# home/apps/terminal/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.terminal;
in
{
  imports = [
    ./emulators
    ./utils
  ];

  options.rhodium.home.apps.terminal = {
    enable = mkEnableOption "Rhodium's terminal configuration";
  };

  config = mkIf cfg.enable {
  };
}
