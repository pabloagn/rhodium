# home/apps/browsers/librewolf.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.browsers.librewolf;
in
{
  options.rhodium.apps.browsers.librewolf = {
    enable = mkEnableOption "Librewolf Browser";
  };

  config = mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
    };
  };
}
