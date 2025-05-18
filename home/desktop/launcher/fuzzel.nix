# home/desktop/launcher/fuzzel.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.desktop.launcher.fuzzel;
in
{
  options.rhodium.desktop.launcher.fuzzel = {
    enable = mkEnableOption "Rhodium's Fuzzel Launcher";
  };

  config = mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;
      package = pkgs.fuzzel;
    };
    xdg.configFile."fuzzel/fuzzel.ini" = {
      source = ./fuzzel/fuzzel.ini;
    };
  };
}
