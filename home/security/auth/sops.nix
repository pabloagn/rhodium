# home/security/auth/sops.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.security.auth.sops;
in
{
  options.rhodium.security.auth.sops = {
    enable = mkEnableOption "Rhodium's sops configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      sops
      age
    ];
  };
}
