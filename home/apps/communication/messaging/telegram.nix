# home/apps/communication/messaging/telegram.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.communication.messaging.telegram;
in
{
  options.rhodium.home.apps.communication.messaging.telegram = {
    enable = mkEnableOption "Telegram";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      telegram-desktop
    ];
  };
}
