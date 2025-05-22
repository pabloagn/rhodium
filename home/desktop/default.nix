# home/desktop/default.nix

{ lib, config, pkgs, inputs ? { }, ... }:

with lib;
let
  cfg = config.rhodium.home.desktop;
  parentCfg = config.rhodium.home;
  categoryName = "desktop";
in
{
  imports = [
    ./wm/default.nix
    ./launchers/default.nix
    ./bar/default.nix
    ./notifications/default.nix
  ];

  options.rhodium.home.${categoryName} = {
    enable = mkEnableOption "Rhodium's ${categoryName}" // { default = false; };
  };

  config = rhodium.lib.mkChildConfig parentCfg cfg {
    rhodium.home.${categoryName} = {
      bar.enable = false;
      launchers.enable = false;
      notifications.enable = false;
      wm = {
        enable = false;
        hyprcursor = {
          enable = false;
          theme = "rose-pine";
          size = 20;
        };
        hyprland = {
          enable = false;
        };
        hyprpaper = {
          enable = false;
        };
      };
    };
  };
}
