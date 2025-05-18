# home/apps/communication/messaging/teams.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.communication.messaging.teams;
in
{
  options.rhodium.apps.communication.messaging.teams = {
    enable = mkEnableOption "Teams";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      teams-for-linux
    ];
  };
}
