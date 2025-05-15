# home/development/languages/r.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.r;
in
{
  options.home.development.languages.r = {
    enable = mkEnableOption "Enable R development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # R Language Environment
      R

      # Language Server (R package 'languageserver')
      # Install via R: install.packages("languageserver")
      # Or, if a Nix package wrapper exists:
      rPackages.languageserver

      # Linters (R package 'lintr')
      # Install via R: install.packages("lintr")
      # Or, if a Nix package wrapper exists:
      rPackages.lintr

      # Other useful tools
      # radian # Alternative R console
    ];
  };
}
