# home/desktop/launcher/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.desktop.launcher;
in
{
  imports = [
    ./rofi.nix
    ./fuzzel.nix
  ];

  options.rhodium.home.desktop.launcher = {
    enable = mkEnableOption "Rhodium's Desktop Launchers";
  };

  config = mkIf cfg.enable {
    rhodium.home.desktop.launcher = {
      rofi.enable = true;
      fuzzel.enable = true;
    };
  };
}
