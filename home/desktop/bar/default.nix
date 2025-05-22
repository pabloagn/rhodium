# home/desktop/bar/default.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.desktop.bar;
  parentCfg = config.rhodium.home.desktop;
  categoryName = "bar";
in
{
  imports = [
    ./waybar.nix
  ];

  options.rhodium.home.desktop.${categoryName} = {
    enable = mkEnableOption "Rhodium's Desktop ${categoryName}" // { default = false; };
  };

  config = rhodium.lib.mkChildConfig parentCfg cfg {
    rhodium.home.desktop.bar.waybar.enable = false;
  };
}
