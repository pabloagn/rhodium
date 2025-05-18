# home/apps/communication/messaging/whatsapp.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.communication.messaging.whatsapp;
in
{
  options.rhodium.apps.communication.messaging.whatsapp = {
    enable = mkEnableOption "WhatsApp";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      whatsapp-for-linux
    ];
  };
}
