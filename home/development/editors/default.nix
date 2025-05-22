# home/development/editors/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;

  packageSpecs = [
    {
      name = "kakoune";
      pkg = pkgs.kakoune;
      description = "A modal text editor";
      hasDesktop = true;
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath ({
    enable = mkEnableOption "Rhodium's ${categoryName} configuration";
  } // rhodiumLib.mkIndividualPackageOptions packageSpecs);

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;

    emacs.enable = false;
    helix.enable = false;
    kate.enable = false;
    mousepad.enable = false;
    nvim.enable = false;
  };
}
