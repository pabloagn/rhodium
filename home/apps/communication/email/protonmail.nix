# home/apps/communication/email/protonmail.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.communication.email.protonmail;
in
{
  options.rhodium.home.apps.communication.email.protonmail = {
    enable = mkEnableOption "Protonmail";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      protonmail-bridge
      protonmail-bridge-gui
      protonmail-desktop
    ];
  };
}
