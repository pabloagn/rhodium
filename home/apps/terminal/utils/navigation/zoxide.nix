# home/apps/terminal/utils/navigation/zoxide.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.terminal.utils.navigation.zoxide;
in
{
  options.rhodium.home.apps.terminal.utils.navigation.zoxide = {
    enable = mkEnableOption "Rhodium's zoxide configuration";
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
    };
  };
}
