# home/apps/productivity/cloud/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;
  packageSpecs = [
    {
      name = "nextcloud";
      pkg = pkgs.nextcloud;
      description = "Nextcloud personal information management suite";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath
    {
      enable = mkEnableOption "Rhodium's ${categoryName} applications";
    } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}
