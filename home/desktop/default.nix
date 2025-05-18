# home/desktop/default.nix

{ lib, config, pkgs, inputs ? {}, ... }:

with lib;
let
  cfg = config.rhodium.desktop;
in
{
  imports = [
    ./wm
    ./launcher
    ./bar
    ./notifications
  ];

  options.rhodium.desktop = {
    enable = mkEnableOption "Rhodium's Desktop";
  };

  config = mkIf cfg.enable {
    rhodium.desktop.bar.enable = true;
    rhodium.desktop.launcher.enable = true;
    rhodium.desktop.notifications.enable = true;
    rhodium.desktop.wm.enable = true;
  };
}
