# home/apps/communication/messaging/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.communication.messaging;
in
{
  imports = [
    ./signal.nix
    ./whatsapp.nix
    ./telegram.nix
    ./slack.nix
    ./teams.nix
    ./zoom.nix
  ];

  options.rhodium.apps.communication.messaging = {
    enable = mkEnableOption "Messaging applications";
  };

  config = mkIf cfg.enable {
    rhodium.apps.communication.messaging.signal.enable = true;
    rhodium.apps.communication.messaging.whatsapp.enable = true;
    rhodium.apps.communication.messaging.telegram.enable = false;
    rhodium.apps.communication.messaging.slack.enable = true;
    rhodium.apps.communication.messaging.teams.enable = true;
    rhodium.apps.communication.messaging.zoom.enable = false;
  };
}
