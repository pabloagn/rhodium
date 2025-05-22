# home/desktop/notifications/default.nix

{ config, lib, pkgs, rhodium, ... }:

with lib;
let
  cfg = config.rhodium.home.desktop.notifications;
  parentCfg = config.rhodium.home.desktop;
  categoryName = "notifications";
in
{
  imports = [
    ./dunst.nix
  ];

  options.rhodium.home.desktop.${categoryName} = {
    enable = mkEnableOption "Rhodium's Desktop ${categoryName}" // { default = false; };
  };

  config = rhodium.lib.mkChildConfig parentCfg cfg {
    rhodium.home.desktop.notifications.dunst.enable = false;
  };
}
