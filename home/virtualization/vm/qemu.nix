# home/virtualization/vm/qemu.nix

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
      hasDesktop = false;
      defaultEnable = false;
    }
  );

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = with pkgs; [
      qemu
      kvmtools
    ];
  };
}
