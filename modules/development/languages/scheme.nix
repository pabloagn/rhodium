# modules/development/languages/scheme.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.scheme;
in
{
  options.rhodium.system.development.languages.scheme = {
    enable = mkEnableOption "Enable Scheme development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Scheme Interpreters/Compilers
      guile # GNU Guile
      chicken # CHICKEN Scheme
      chezscheme # Chez Scheme
      # mit-scheme

      # Language Server (availability varies)
      # scheme-langserver # (check if this package exists or how to obtain it)
      # Some Scheme implementations might have their own LSP or editor integration.
    ];
  };
}
