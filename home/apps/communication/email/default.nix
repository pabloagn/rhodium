# home/apps/communication/email/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.communication.email;
in
{
  imports = [
    ./protonmail.nix
    ./thunderbird.nix
  ];

  options.rhodium.apps.communication.email = {
    enable = mkEnableOption "Email applications";
  };

  config = mkIf cfg.enable {
    rhodium.apps.communication.email.protonmail.enable = true;
    rhodium.apps.communication.email.thunderbird.enable = false;
  };
}
