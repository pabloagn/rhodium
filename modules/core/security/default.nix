# modules/core/security/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.core.security;
in
{
  imports = [
    ./keyring.nix
    ./sops.nix
  ];

  options.rhodium.system.core.security = {
    enable = mkEnableOption "Security (core)";
  };

  config = mkIf cfg.enable {
    rhodium.system.core.security = {
      keyring.enable = true;
      sops.enable = true;
    };
  };
}
