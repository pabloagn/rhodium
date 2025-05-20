# home/desktop/default.nix

{ lib, config, pkgs, inputs ? { }, ... }:

with lib;
let
  cfg = config.rhodium.home.desktop;
in
{
  imports = [
    ./wm
    ./launcher
    ./bar
    ./notifications
  ];

  options.rhodium.home.desktop = {
    enable = mkEnableOption "Rhodium's Desktop";
  };

  config = mkIf cfg.enable {
    rhodium.home.desktop = {
      bar.enable = true;
      launcher.enable = true;
      notifications.enable = true;
      wm = {
        enable = true;
        hyprcursor = {
          enable = true;
          theme = "rose-pine";
          size = 20;
        };
      };
    };
  };
}
