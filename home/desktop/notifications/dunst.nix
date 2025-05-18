# home/desktop/notifications/dunst.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.desktop.notifications.dunst;
in
{
  options.rhodium.desktop.notifications.dunst = {
    enable = mkEnableOption "Rhodium's Dunst Notifications";
  };

  config = mkIf cfg.enable {
    services.dunst.enable = true;
    services.dunst.package = pkgs.dunst;
  };
}
