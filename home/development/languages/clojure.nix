# home/development/languages/clojure.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.clojure;
in
{
  options.home.development.languages.clojure = {
    enable = mkEnableOption "Enable Clojure development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Runtime & Build Tools
      clojure
      leiningen
      # boot # Alternative build tool

      # Language Server
      clojure-lsp

      # For ClojureScript
      # shadow-cljs # (via nodePackages if preferred)
    ];
  };
}
