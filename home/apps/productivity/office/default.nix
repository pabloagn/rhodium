# home/apps/documents/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Document processing applications";
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    libreoffice.enable = false;
    onlyoffice.enable = false;
    okular.enable = false;
    zathura.enable = false;
    texmaker.enable = false;
  };
}
