# home/security/privacy/default.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.security.privacy;
in
{
  options.rhodium.security.privacy = {
    enable = mkEnableOption "Privacy tools";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # VPN
      protonvpn-cli
      protonvpn-gui
    ];
  };
}
