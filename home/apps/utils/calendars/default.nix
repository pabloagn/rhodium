# home/apps/utils/calendars/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;

  packageSpecs = [
    {
      name = "korganizer";
      pkg = pkgs.kdePackages.korganizer;
      description = "KOrganizer calendar and scheduling application (KDE)";
    }
    {
      name = "evolution";
      pkg = pkgs.evolution;
      description = "Evolution personal information management suite (includes calendar)";
    }
    {
      name = "calcurse";
      pkg = pkgs.calcurse;
      description = "Calcurse calendar and scheduling application for the command line";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath
    {
      enable = mkEnableOption "Calendar applications";
    } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}
