# home/apps/communication/messaging/signal.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.communication.messaging.signal;
in
{
  options.rhodium.home.apps.communication.messaging.signal = {
    enable = mkEnableOption "Signal";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      signal-desktop
    ];
  };
}
