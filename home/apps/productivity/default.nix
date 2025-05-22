# home/apps/productivity/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Productivity applications";
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    cloud.enable = false;
    crm.enable = false;
    documents.enable = false;
    files.enable = false;
    finance.enable = false;
    office.enable = false;
    recipes.enable = false;
    tasks.enable = false;
    workflow.enable = false;
  };
}
