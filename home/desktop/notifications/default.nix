# home/desktop/notifications/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.desktop.notifications;
in
{
  imports = [
    ./dunst.nix
  ];

  options.rhodium.home.desktop.notifications = {
    enable = mkEnableOption "Rhodium's Desktop Notifications";
  };

  config = mkIf cfg.enable {
    rhodium.home.desktop.notifications.dunst.enable = true;
  };
}
