# home/apps/terminal/utils/zoxide.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.apps.terminal.utils.zoxide;
in
{
  options.rhodium.apps.terminal.utils.zoxide = {
    enable = mkEnableOption "Rhodium's zoxide configuration";
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
    };
  };
}
