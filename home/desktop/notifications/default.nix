# home/desktop/notifications/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.desktop.notifications;
in
{
  imports = [
    ./dunst.nix
  ];

  options.rhodium.desktop.notifications = {
    enable = mkEnableOption "Rhodium's Desktop Notifications";
  };

  config = mkIf cfg.enable {
    rhodium.desktop.notifications.dunst.enable = true;
  };
}
