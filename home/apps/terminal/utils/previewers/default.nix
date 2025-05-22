# home/apps/terminal/utils/previewers/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;

let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;

  packageSpecs = [
    {
      name = "mdcat";
      pkg = pkgs.mdcat;
      description = "Fancy cat for Markdown";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath ({
    enable = mkEnableOption "Rhodium's ${categoryName} configuration";
  } // rhodiumLib.mkIndividualPackageOptions packageSpecs);

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;

    bat.enable = false;
    glow.enable = false;
  };
}
