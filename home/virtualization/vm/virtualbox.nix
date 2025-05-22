# home/virtualization/vm/virtualbox.nix

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
      hasDesktop = true;
      defaultEnable = false;
    }
  );

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = [
      pkgs.virtualbox
    ];
  };
}
