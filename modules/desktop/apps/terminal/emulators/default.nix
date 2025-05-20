# modules/desktop/apps/terminal/emulators/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.desktop.apps.terminal.emulators;
in
{
  imports = [
    ./kitty.nix
    ./ghostty.nix
  ];

  options.rhodium.system.desktop.apps.terminal.emulators = {
    enable = mkEnableOption "Terminal emulators";
  };

  config = mkIf cfg.enable {
  };
}
