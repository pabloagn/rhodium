# home/apps/smart_home/default.nix

{ config, lib, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;

  packageSpecs = [
    {
      name = "home-assistant";
      pkg = pkgs.home-assistant;
      description = "Self-hosted smart home automation";
    }
    {
      name = "home-assistant-configurator";
      pkg = pkgs.home-assistant-configurator;
      description = "Self-hosted smart home automation";
    }
    {
      name = "node-red";
      pkg = pkgs.node-red;
      description = "Self-hosted smart home automation";
    }
    {
      name = "frigate";
      pkg = pkgs.frigate;
      description = "Self-hosted smart home automation";
    }
    {
      name = "motioneye";
      pkg = pkgs.motioneye;
      description = "Self-hosted smart home automation";
    }
    {
      name = "scrypted";
      pkg = pkgs.scrypted;
      description = "Self-hosted smart home automation";
    }
    {
      name = "n8n";
      pkg = pkgs.n8n;
      description = "Self-hosted smart home automation";
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
