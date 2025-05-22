# home/apps/terminal/utils/navigation/zoxide.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
in
{
  options = setAttrByPath _haumea.configPath (
    rhodiumLib.mkAppModuleOptions {
      appName = categoryName;
      appDescription = "${rhodiumLib.metadata.appName}'s ${categoryName} configuration";
      hasDesktop = false;
    }
  );

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    programs.zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
  };
}
