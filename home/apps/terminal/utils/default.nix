# home/apps/terminal/utils/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = "utils";
in
{

  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Rhodium's terminal ${categoryName}" // { default = false; };
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    compression.enable = false;
    development.enable = false;
    finders.enable = false;
    multiplexers.enable = false;
    navigation.enable = false;
    networking.enable = false;
    previewers.enable = false;
    processing.enable = false;
    productivity.enable = false;
    system.enable = false;
  };
}
