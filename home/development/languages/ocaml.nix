# home/development/languages/ocaml.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.ocaml;
in
{
  options.home.development.languages.ocaml = {
    enable = mkEnableOption "Enable OCaml development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # OCaml Compiler
      ocaml

      # Package Manager
      opam

      # Build System
      dune # Common build system for OCaml

      # Language Server
      ocaml-lsp # (ocaml-language-server)
      # ocamlmerlin # Merlin is also widely used, often integrated with ocaml-lsp

      # Formatter
      ocamlformat
    ];
  };
}
