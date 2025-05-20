# home/apps/terminal/utils/productivity/default.nix

{ config, lib, pkgs, rhodium, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.terminal.utils.productivity;
  categoryName = "productivity";

  packageSpecs = [
    { name = "glow"; pkg = pkgs.glow; description = "Markdown renderer for the terminal"; }
    { name = "mdcat"; pkg = pkgs.mdcat; description = "Fancy cat for Markdown"; }
    { name = "asciinema"; pkg = pkgs.asciinema; description = "Terminal session recorder"; }
    { name = "direnv"; pkg = pkgs.direnv; description = "Environment switcher for the shell"; }
    { name = "progress"; pkg = pkgs.progress; description = "Show progress for coreutils commands"; }
    { name = "pv"; pkg = pkgs.pv; description = "Pipe viewer to monitor data through a pipeline"; }
    { name = "parallel"; pkg = pkgs.parallel; description = "Execute commands in parallel"; }
    { name = "bc"; pkg = pkgs.bc; description = "Command line calculator"; }
    { name = "hexyl"; pkg = pkgs.hexyl; description = "Hex viewer with colors"; }
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
