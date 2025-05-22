# home/apps/files/nautilus.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Nautilus";
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = with pkgs; [
      nautilus
    ];
  };
}
