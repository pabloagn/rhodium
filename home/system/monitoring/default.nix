# home/system/monitoring/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  categoryName = _haumea.name;

  packageSpecs = [
    {
      name = "acpi";
      pkg = pkgs.acpi;
      description = "Client for battery, power, and thermal readings.";
    }
    {
      name = "bottom";
      pkg = pkgs.bottom;
      description = "A cross-platform graphical process/system monitor with a TUI.";
    }
    {
      name = "v4l-utils";
      pkg = pkgs.v4l-utils;
      description = "Utilities for Video4Linux devices.";
    }
    {
      name = "upower";
      pkg = pkgs.upower;
      description = "Provides an interface to enumerate power sources on the system.";
    }
    {
      name = "scrutiny";
      pkg = pkgs.scrutiny;
      description = "Scrutiny: A tool for monitoring and managing disk health";
    }
  ];
in
{
  options = setAttrByPath _haumea.configPath
    {
      enable = mkEnableOption "Rhodium's ${categoryName} configurations";
    } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}
