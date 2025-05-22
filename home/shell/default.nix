# home/shell/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Rhodium's ${categoryName} configuration" // { default = false; };
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    common.enable = false;
    shells.enable = false;
    prompts.enable = false;
    utils.enable = false;
  };
}
