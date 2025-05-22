# home/apps/terminal/emulators/kitty.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Rhodium's ${categoryName} configuration";
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    programs.kitty = {
      enable = true;
      package = pkgs.kitty;
    };

    xdg.configFile."kitty/kitty.conf" = {
      source = ./kitty/kitty.conf;
    };

    xdg.configFile."kitty/themes/catppuccin-mocha.conf" = {
      source = ./kitty/themes/catppuccin-mocha.conf;
    };
  };
}
