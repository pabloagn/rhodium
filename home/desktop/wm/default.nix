# home/desktop/wm/default.nix

{ config, lib, pkgs, rhodium, inputs ? { }, ... }:

with lib;
let
  cfg = config.rhodium.home.desktop.wm;
  parentCfg = config.rhodium.home.desktop;
  categoryName = "wm";
in
{
  imports = [
    ./hyprland.nix
    ./hyprcursor.nix
    ./hyprpaper.nix
  ];

  options.rhodium.home.desktop.wm = {
    enable = mkEnableOption "Rhodium's Desktop ${categoryName}" // { default = false; };
  };

  config = rhodium.lib.mkChildConfig parentCfg cfg {
    hyprland.enable = false;
    hyprcursor.enable = false;
    hyprpaper.enable = false;
  };
}
