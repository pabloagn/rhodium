# home/security/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.security;
in {
  imports = [
    ./auth
    ./opsec
    ./privacy
  ];

  options.rhodium.security = {
    enable = mkEnableOption "Security tools and configurations";
  };

  config = mkIf cfg.enable {
    rhodium.security.auth.enable = true;
    rhodium.security.opsec.enable = true;
    rhodium.security.privacy.enable = true;
  };
}
