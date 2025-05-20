# home/apps/communication/messaging/default.nix
# DONE

{ config, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.communication.messaging;
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

  options.rhodium.home.apps.communication.messaging = {
    enable = mkEnableOption "Messaging applications";
  };

  config = mkIf cfg.enable {
    rhodium.home.apps.communication.messaging = {
      signal.enable = false;
      whatsapp.enable = false;
      telegram.enable = false;
      slack.enable = false;
      teams.enable = false;
      zoom.enable = false;
    };
  };
}
