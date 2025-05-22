# home/apps/files/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "File managers";
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    dolphin.enable = false;
    krusader.enable = false;
    nautilus.enable = false;
    thunar.enable = false;
  };
}
