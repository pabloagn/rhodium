# home/apps/browsers/w3m.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.browsers.w3m;
in
{
  options.rhodium.apps.browsers.w3m = {
    enable = mkEnableOption "w3m terminal browser";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      w3m
    ];
  };
}
