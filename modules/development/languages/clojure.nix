# modules/development/languages/clojure.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.clojure;
in
{
  options.modules.development.languages.clojure = {
    enable = mkEnableOption "Enable Clojure development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
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
