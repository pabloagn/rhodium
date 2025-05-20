# home/apps/communication/default.nix
# DONE

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.communication;
in
{
  imports = [
    ./messaging/default.nix
    ./email/default.nix
  ];

  options.rhodium.home.apps.communication = {
    enable = mkEnableOption "Communication applications";
  };

  config = mkIf cfg.enable {
    rhodium.home.apps.communication = {
      messaging.enable = false;
      email.enable = false;
    };
  };
}
