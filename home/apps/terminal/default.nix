# home/apps/terminal/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Rhodium's ${categoryName} applications and utilities" // { default = false; };
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    emulators.enable = false;
    utils.enable = false;
  };
}
