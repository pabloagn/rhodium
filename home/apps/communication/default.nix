# home/apps/communication/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Rhodium's ${categoryName} applications" // { default = false; };
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    email.enable = false;
    feeds.enable = false;
    messaging.enable = false;
    social.enable = false;
  };
}
