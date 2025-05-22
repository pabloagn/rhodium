# home/apps/documents/libreoffice.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "LibreOffice";
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = with pkgs; [
      libreoffice
    ];
  };
}
