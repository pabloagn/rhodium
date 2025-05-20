# modules/development/languages/clojure.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.clojure;
in
{
  options.rhodium.system.development.languages.clojure = {
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
