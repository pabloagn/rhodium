# home/development/ides/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;

  packageSpecs = [ ];
in
{
  options = setAttrByPath _haumea.configPath ({
    enable = mkEnableOption "Rhodium's ${categoryName} configuration";
  } // rhodiumLib.mkIndividualPackageOptions packageSpecs);

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;

    cursor.enable = false;
    lapce.enable = false;
    rstudio.enable = false;
    vscode.enable = false;
    zed.enable = false;
  };
}
