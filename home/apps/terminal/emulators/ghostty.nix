# home/apps/terminal/emulators/ghostty.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;
  appNamePossessive = rhodiumLib.metadata.appNamePossessive;
  optionDescription = "${appNamePossessive} ${categoryName} configuration";
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption optionDescription;
  };

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      package = pkgs.ghostty;
    };

    xdg.configFile."ghostty/config" = {
      source = ./ghostty/config;
    };
  };
}
