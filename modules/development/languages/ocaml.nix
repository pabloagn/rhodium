# modules/development/languages/ocaml.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.ocaml;
in
{
  options.rhodium.system.development.languages.ocaml = {
    enable = mkEnableOption "Enable OCaml development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
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
