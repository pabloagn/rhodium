# home/apps/communication/messaging/zoom.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.communication.messaging.zoom;
in
{
  options.rhodium.home.apps.communication.messaging.zoom = {
    enable = mkEnableOption "Zoom";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zoom-us
    ];
  };
}
