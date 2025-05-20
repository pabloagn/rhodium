# home/apps/communication/email/default.nix
# DONE

{ config, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.communication.email;
in
{
  imports = [
    ./protonmail.nix
    ./thunderbird.nix
  ];

  options.rhodium.home.apps.communication.email = {
    enable = mkEnableOption "Email applications";
  };

  config = mkIf cfg.enable {
    rhodium.home.apps.communication.email = {
      protonmail.enable = false;
      thunderbird.enable = false;
    };
  };
}
