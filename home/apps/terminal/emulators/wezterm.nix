# home/apps/terminals/emulators/wezterm.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.terminals.emulators.wezterm;
in
{
  options.rhodium.home.apps.terminals.emulators.wezterm = {
    enable = mkEnableOption "Rhodium's Wezterm configuration";
  };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      package = pkgs.wezterm;
      enableZshIntegration = true;
      enableBashIntegration = true;
      extraConfig = builtins.readFile ./wezterm/wezterm.lua;
    };
  };
}
