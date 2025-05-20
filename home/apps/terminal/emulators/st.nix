# home/apps/terminals/emulators/st.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.terminals.emulators.st;
in
{
  options.rhodium.home.apps.terminals.emulators.st = {
    enable = mkEnableOption "Rhodium's ST configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      st
    ];
  };
}
