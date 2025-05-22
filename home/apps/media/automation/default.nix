# home/apps/media/automation/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  packageSpecs = [
    {
      name = "sonarr";
      pkg = pkgs.sonarr;
      description = "A fork of Radarr for managing and downloading movies";
    }
    {
      name = "radarr";
      pkg = pkgs.radarr;
      description = "A fork of Radarr for managing and downloading movies";
    }
    {
      name = "prowlarr";
      pkg = pkgs.prowlarr;
      description = "A fork of Radarr for managing and downloading movies";
    }
    {
      name = "bazarr";
      pkg = pkgs.bazarr;
      description = "A fork of Bazarr for managing and downloading movies";
    }
    {
      name = "overseer";
      pkg = pkgs.overseer;
      description = "A fork of Overseer for managing and downloading movies";
    }
    {
      name = "lidarr";
      pkg = pkgs.lidarr;
      description = "A fork of Lidarr for managing and downloading music";
    }
    {
      name = "readarr";
      pkg = pkgs.readarr;
      description = "A fork of Readarr for managing and downloading books";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath
    {
      enable = mkEnableOption "Rhodium's automation applications";
    } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}
