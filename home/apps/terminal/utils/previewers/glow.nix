# home/apps/terminal/utils/previewers/glow.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Rhodium's ${categoryName} configuration";
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    programs.glow = {
      enable = true;
      # TODO: Add themes, etc
    };
  };
}
