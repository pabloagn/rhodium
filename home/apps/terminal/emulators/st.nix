# home/apps/terminals/emulators/st.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.terminals.emulators.st;
in
{
  options.rhodium.apps.terminals.emulators.st = {
    enable = mkEnableOption "Rhodium's ST configuration";
  };

  config = mkIf (config.rhodium.apps.terminals.emulators.enable && cfg.enable) {
    home.packages = with pkgs; [
      st
    ];
  };
}
