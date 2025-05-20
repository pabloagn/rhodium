# home/apps/terminals/emulators/foot.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.terminals.emulators.foot;
in
{
  options.rhodium.home.apps.terminals.emulators.foot = {
    enable = mkEnableOption "Rhodium's Foot configuration";
  };

  config = mkIf cfg.enable {
    programs.foot = {
      enable = true;
      package = pkgs.foot;
    };
  };
}
