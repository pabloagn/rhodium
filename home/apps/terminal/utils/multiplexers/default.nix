# home/apps/terminal/utils/multiplexers/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;

  packageSpecs = [
    {
      name = "zellij";
      pkg = pkgs.zellij;
      description = "Terminal multiplexer and workspace";
    }
    {
      name = "tmux";
      pkg = pkgs.tmux;
      description = "Terminal multiplexer";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "Rhodium's ${categoryName} terminal utils" // { default = false; };
  } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}
