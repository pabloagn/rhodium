# modules/desktop/apps/terminal/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.desktop.apps.terminal;
in
{
  imports = [
    ./emulators
  ];

  options.rhodium.system.desktop.apps.terminal = {
    enable = mkEnableOption "Rhodium's terminal configuration";
  };

  config = mkIf cfg.enable {
    rhodium.system.desktop.apps.terminal = {
      emulators.enable = true;
    };
  };
}
