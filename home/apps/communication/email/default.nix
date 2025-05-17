# home/apps/communication/email/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.communication.email;
in
{
  options.rhodium.apps.communication.email = {
    enable = mkEnableOption "Email applications";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      thunderbird
      protonmail-bridge
      protonmail-bridge-gui
      protonmail-desktop
    ];
  };
}
