# home/apps/terminal/utils/processing/default.nix

{ config, lib, pkgs, rhodium, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.terminal.utils.processing;
  categoryName = "processing";

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
  options.rhodium.home.apps.terminal.utils.${categoryName} = {
    enable = mkEnableOption "Rhodium's ${categoryName} terminal utils";
  } // rhodium.lib.mkIndividualPackageOptions packageSpecs;

  config = mkIf cfg.enable {
    home.packages = concatMap (spec: if cfg.${spec.name}.enable then [ spec.pkg ] else [ ]) packageSpecs;
  };
}
