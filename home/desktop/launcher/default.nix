# home/desktop/launcher/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.desktop.launcher;
in
{
  imports = [
    ./rofi.nix
    ./fuzzel.nix
  ];

  options.rhodium.desktop.launcher = {
    enable = mkEnableOption "Rhodium's Desktop Launchers";
  };

  config = mkIf cfg.enable {
    rhodium.desktop.launcher.rofi.enable = true;
    rhodium.desktop.launcher.fuzzel.enable = true;
  };
}
