# modules/development/languages/r.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.r;
in
{
  options.modules.development.languages.r = {
    enable = mkEnableOption "Enable R development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # R Language Environment
      R

      # Language Server (R package 'languageserver')
      # This needs to be installed within R, but having R available is the first step.
      # You can install it via R: install.packages("languageserver")
      # Or, if a Nix package wrapper exists:
      # r-languageserver # (check actual package name)
      # For now, we provide R and the R package itself if you want to manage it via Nix.
      rPackages.languageserver

      # Linters (R package 'lintr')
      # Install via R: install.packages("lintr")
      # Or, if a Nix package wrapper exists:
      rPackages.lintr

      # Other useful tools
      # rstudio-server # RStudio Server (IDE)
      # radian # Alternative R console
    ];
    # Note: Many R tools and packages (like the LSP) are often installed using R's own package manager.
    # This module provides the core R environment.
  };
}
