# home/apps/browsers/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;

  packageSpecs = [
    {
      name = "brave";
      pkg = pkgs.brave;
      description = "Privacy-focused browser that blocks ads and trackers by default.";
      hasDesktop = true;
    }
    {
      name = "chromium";
      pkg = pkgs.chromium;
      description = "Open-source web browser project from which Google Chrome draws its source code.";
      hasDesktop = true;
    }
    {
      name = "w3m";
      pkg = pkgs.w3m;
      description = "Text-based web browser as well as a pager.";
      hasDesktop = true;
    }
    {
      name = "librewolf";
      pkg = pkgs.librewolf;
      description = "A fork of Firefox, focused on privacy, security and freedom.";
      hasDesktop = true;
    }
    {
      name = "qutebrowser";
      pkg = pkgs.qutebrowser;
      description = "A keyboard-focused browser with a minimal GUI.";
      hasDesktop = true;
    }
    {
      name = "tor";
      pkg = pkgs.tor;
      description = "The tor browser.";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath ({
    enable = mkEnableOption "Rhodium's ${categoryName} configuration";
  } // rhodiumLib.mkIndividualPackageOptions packageSpecs);

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;

    firefox.enable = false;
    zen.enable = false;
  };
}
