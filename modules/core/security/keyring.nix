# modules/core/security/keyring.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.core.security.keyring;
in
{
  options.rhodium.system.core.security.keyring = {
    enable = mkEnableOption "Keyring (system)";
  };

  config = mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true;
  };
}
