# home/desktop/launchers/default.nix

{ lib, config, pkgs, rhodium, ... }:

with lib;
let
  cfg = config.rhodium.home.desktop.launchers;
  parentCfg = config.rhodium.home.desktop;
  categoryName = "launchers";
in
{
  imports = [
    ./rofi.nix
    ./fuzzel.nix
  ];

  options.rhodium.home.desktop.${categoryName} = {
    enable = mkEnableOption "Rhodium's Desktop ${categoryName}" // { default = false; };
  };

  config = rhodium.lib.mkChildConfig parentCfg cfg {
    rhodium.home.desktop.launchers = {
      rofi.enable = false;
      fuzzel.enable = false;
    };
  };
}
