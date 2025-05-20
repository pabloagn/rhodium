# home/apps/terminal/utils/multiplexers/default.nix

{ config, lib, pkgs, rhodium, ... }:

with lib;
let
  cfg = config.rhodium.home.apps.terminal.utils.multiplexers;
  categoryName = "multiplexers";

  packageSpecs = [
    { name = "zellij"; pkg = pkgs.zellij; description = "Terminal multiplexer and workspace"; }
    { name = "tmux"; pkg = pkgs.tmux; description = "Terminal multiplexer"; }
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
