# home/development/languages/scheme.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.scheme;
in
{
  options.home.development.languages.scheme = {
    enable = mkEnableOption "Enable Scheme development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Scheme Interpreters/Compilers
      guile # GNU Guile
      chicken # CHICKEN Scheme
      chezscheme # Chez Scheme
      # mit-scheme
      texlive.combined.scheme-full # For schemes like scheme-basic, etc. (as per your example)

      # Language Server (availability varies)
      # scheme-langserver # (check if this package exists or how to obtain it)
    ];
  };
}
