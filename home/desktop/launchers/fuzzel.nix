# home/desktop/launcher/fuzzel.nix

{ lib, config, pkgs, rhodium, ... }:

with lib;
let
  cfg = config.rhodium.home.desktop.launchers.fuzzel;
  parentCfg = config.rhodium.home.desktop.launchers;
in
{
  options.rhodium.home.desktop.launchers.fuzzel = {
    enable = mkEnableOption "Rhodium's Fuzzel Launcher" // { default = false; };
  };

  config = rhodium.lib.mkChildConfig parentCfg cfg {
    programs.fuzzel = {
      enable = true;
      package = pkgs.fuzzel;
    };

    xdg.configFile."fuzzel/fuzzel.ini" = {
      source = ./fuzzel/fuzzel.ini;
    };
  };
}
