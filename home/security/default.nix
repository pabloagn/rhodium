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
    ./passwords
  ];

  options.rhodium.security = {
    enable = mkEnableOption "Security tools and configurations";
  };

  config = mkIf cfg.enable {
  };
}
