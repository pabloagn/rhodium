# home/virtualization/compatibility/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;

  packageSpecs = [ ];
in
{
  options = setAttrByPath _haumea.configPath ({
    enable = mkEnableOption "Rhodium's ${categoryName} configuration";
  } // rhodiumLib.mkIndividualPackageOptions packageSpecs);

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;

    wine.enable = false;
  };
}
