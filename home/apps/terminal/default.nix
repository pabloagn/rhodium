# home/apps/terminal/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.terminal;
in
{
  imports = [
    ./emulators
    ./utils
  ];

  options.rhodium.apps.terminal = {
    enable = mkEnableOption "Rhodium's terminal configuration";
  };

  config = mkIf cfg.enable {
    rhodium.apps.terminal.emulators.enable = true;
    rhodium.apps.terminal.utils.enable = true;
  };
}
