# home/apps/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Rhodium's home ${categoryName}" // { default = false; };
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    browsers.enable = false;
    communication.enable = false;
    desktop.enable = false;
    documents.enable = false;
    files.enable = false;
    media.enable = false;
    opsec.enable = false;
    privacy.enable = false;
    smart_home.enable = false;
    terminal.enable = false;
    utils.enable = false;
  };
}
