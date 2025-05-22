# home/apps/communication/email/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Rhodium's ${categoryName} applications" // { default = false; };
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    protonmail.enable = false;
    thunderbird.enable = false;
  };
}
