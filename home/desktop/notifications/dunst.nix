# home/desktop/notifications/dunst.nix

{ lib, config, pkgs, rhodium, ... }:

with lib;
let
  cfg = config.rhodium.home.desktop.notifications.dunst;
  parentCfg = config.rhodium.home.desktop.notifications;
in
{
  options.rhodium.home.desktop.notifications.dunst = {
    enable = mkEnableOption "Rhodium's Dunst Notifications" // { default = false; };
  };

  config = rhodium.lib.mkChildConfig parentCfg cfg {
    services.dunst = {
      enable = true;
      package = pkgs.dunst;
    };
  };
}
