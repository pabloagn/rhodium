# home/apps/terminal/utils/productivity/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;

let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  packageSpecs = [
    { name = "asciinema"; pkg = pkgs.asciinema; description = "Terminal session recorder"; }
    { name = "progress"; pkg = pkgs.progress; description = "Show progress for coreutils commands"; }
    { name = "pv"; pkg = pkgs.pv; description = "Pipe viewer to monitor data through a pipeline"; }
    { name = "parallel"; pkg = pkgs.parallel; description = "Execute commands in parallel"; }
    { name = "bc"; pkg = pkgs.bc; description = "Command line calculator"; }
    { name = "hexyl"; pkg = pkgs.hexyl; description = "Hex viewer with colors"; }
  ];
in
{
  options = setAttrByPath _haumea.configPath
    {
      enable = mkEnableOption "Rhodium's ${categoryName} terminal utils";
    } // rhodiumLib.mkIndividualPackageOptions packageSpecs;

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}
