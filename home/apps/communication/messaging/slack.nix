# home/apps/communication/messaging/slack.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.communication.messaging.slack;
in
{
  options.rhodium.apps.communication.messaging.slack = {
    enable = mkEnableOption "Slack";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      slack
    ];
  };
}
