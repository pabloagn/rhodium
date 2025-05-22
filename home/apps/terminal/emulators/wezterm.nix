# home/apps/terminal/emulators/wezterm.nix

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
    programs.wezterm = {
      enable = true;
      package = pkgs.wezterm;
      enableZshIntegration = true;
      enableBashIntegration = true;
      extraConfig = builtins.readFile ./wezterm/wezterm.lua;
    };
  };
}
