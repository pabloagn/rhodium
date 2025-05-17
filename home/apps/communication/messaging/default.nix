# home/apps/communication/messaging/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.communication.messaging;
in
{
  options.rhodium.apps.communication.messaging = {
    enable = mkEnableOption "Messaging applications";
  };

  config = mkIf (config.rhodium.apps.communication.enable && cfg.enable) {
    home.packages = with pkgs; [
      signal-desktop
      whatsapp-for-linux
      telegram-desktop
      slack
      teams-for-linux
    ];
  };
}
