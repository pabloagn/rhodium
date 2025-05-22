# home/apps/terminal/utils/processing/default.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  categoryName = _haumea.name;
  cfg = getAttrFromPath _haumea.configPath config;
  parentCfg = getAttrFromPath (lists.init _haumea.configPath) config;
  packageSpecs = [
    { name = "jq"; pkg = pkgs.jq; description = "JSON processor and query language"; }
    { name = "yq-go"; pkg = pkgs.yq-go; description = "YAML processor (inspired by jq)"; }
    { name = "xsv"; pkg = pkgs.xsv; description = "CSV processing toolkit"; }
    { name = "dasel"; pkg = pkgs.dasel; description = "Query and modify data structures across formats"; }
    { name = "choose-rust"; pkg = pkgs.choose-rust; description = "Human-friendly alternative to cut/awk"; }
    { name = "gron"; pkg = pkgs.gron; description = "Make JSON greppable"; }
    { name = "miller"; pkg = pkgs.miller; description = "Tool for querying, shaping CSV/TSV/JSON data"; }
  ];
in
{
  options = setAttrByPath _haumea.configPath (
    rhodiumLib.mkAppModuleOptions
      {
        appName = categoryName;
        appDescription = "${rhodiumLib.metadata.appName}'s ${categoryName} terminal utils";
        hasDesktop = false;
      } // rhodiumLib.mkIndividualPackageOptions packageSpecs
  );

  config = rhodiumLib.mkChildConfig parentCfg cfg {
    home.packages = rhodiumLib.getEnabledPackages cfg packageSpecs;
  };
}
