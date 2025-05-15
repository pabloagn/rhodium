# home/development/languages/nix.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.nix;
in
{
  options.home.development.languages.nix = {
    enable = mkEnableOption "Enable Nix development tools (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Nix Language Server
      nil

      # Nix Formatter
      nixpkgs-fmt
      alejandra # Alternative formatter

      # Nix Tools
      cachix
      nix-info
      # nix-tree # For visualizing derivation dependencies
      # nix-du # For analyzing disk usage of Nix store paths
      # statix # Linter and static analyzer for Nix
      # deadnix # Scan Nix files for dead code (unused variables)
      sbomnix # Utility to generate SBOMs for Nix packages
    ];
  };
}
