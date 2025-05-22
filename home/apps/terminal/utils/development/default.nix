# home/apps/terminal/utils/development/default.nix
{ config, lib, pkgs, rhodium, ... }:
with lib;
let
  cfg = config.rhodium.home.apps.terminal.utils.development;
  parentCfg = config.rhodium.home.apps.terminal.utils;
  categoryName = "development";

  packageSpecs = [
    # Git utilities
    { name = "git"; pkg = pkgs.git; description = "Git version control system"; }
    { name = "git-lfs"; pkg = pkgs.git-lfs; description = "Git extension for large files"; }
    { name = "gitui"; pkg = pkgs.gitui; description = "Terminal UI for git"; }
    { name = "lazygit"; pkg = pkgs.lazygit; description = "Simple terminal UI for git"; }
    { name = "delta"; pkg = pkgs.delta; description = "Syntax-highlighting pager for git diffs"; }
    # Documentation
    { name = "tldr"; pkg = pkgs.tldr; description = "Simplified and community-driven man pages"; }
    { name = "cheat"; pkg = pkgs.cheat; description = "Create and view interactive cheatsheets"; }
    { name = "navi"; pkg = pkgs.navi; description = "Interactive cheatsheet tool with finder"; }
    { name = "tealdeer"; pkg = pkgs.tealdeer; description = "Fast tldr client in Rust"; }
    # Coding aids
    { name = "entr"; pkg = pkgs.entr; description = "Run commands when files change"; }
    { name = "watchexec"; pkg = pkgs.watchexec; description = "Execute commands when files change"; }
    { name = "just"; pkg = pkgs.just; description = "Command runner (like make but simpler)"; }
    { name = "mcfly"; pkg = pkgs.mcfly; description = "Enhanced shell history with intelligent search"; }
    { name = "atuin"; pkg = pkgs.atuin; description = "Shell history with AI"; }
  ];
in
{
  options.rhodium.home.apps.terminal.utils.${categoryName} = {
    enable = mkEnableOption "Rhodium's ${categoryName} utils" // { default = false; };
  } // rhodium.lib.mkIndividualPackageOptions packageSpecs;

  config = rhodium.lib.mkChildConfig parentCfg cfg {
    home.packages = rhodium.lib.getEnabledPackages cfg packageSpecs;
  };
}
