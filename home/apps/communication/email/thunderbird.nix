# home/apps/communication/email/thunderbird.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.communication.email.thunderbird;
in
{
  options.rhodium.home.apps.communication.email.thunderbird = {
    enable = mkEnableOption "Thunderbird";
  };

  config = mkIf cfg.enable {
    programs.thunderbird = {
      enable = true;
      package = pkgs.thunderbird;
    };
  };
}
