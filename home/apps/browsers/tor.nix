# home/apps/browsers/tor.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.browsers.tor;
in
{
  options.rhodium.home.apps.browsers.tor = {
    enable = mkEnableOption "Tor Browser";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      tor-browser-bundle-bin
    ];
  };
}
