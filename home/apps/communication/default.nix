# home/apps/communication/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.communication;
in
{
  imports = [
    ./messaging
    ./email
  ];

  options.rhodium.apps.communication = {
    enable = mkEnableOption "Communication applications";
  };

  config = mkIf cfg.enable {
    rhodium.apps.communication.messaging.enable = true;
    rhodium.apps.communication.email.enable = true;
  };
}
