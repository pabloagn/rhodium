# home/development/languages/ocaml.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.ocaml;
in
{
  options.rhodium.home.development.languages.ocaml = {
    enable = mkEnableOption "Enable OCaml development environment (Home Manager)";

    compiler = mkOption {
      type = types.package;
      default = pkgs.ocaml;
      description = "OCaml compiler.";
    };

    packageManager = mkOption {
      type = types.package;
      default = pkgs.opam;
      description = "OCaml package manager.";
    };

    buildSystem = mkOption {
      type = types.package;
      default = pkgs.dune_3;
      description = "OCaml build system (e.g., dune).";
    };

    languageServer = mkOption {
      type = types.package;
      default = pkgs.ocaml-lsp;
      description = "OCaml Language Server.";
    };

    formatter = mkOption {
      type = types.package;
      default = pkgs.ocamlformat;
      description = "OCaml code formatter.";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [ ocamlmerlin ];
      description = "Additional OCaml-related tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.compiler
      cfg.packageManager
      cfg.buildSystem
      cfg.languageServer
      cfg.formatter
    ] ++ cfg.extraTools;
  };
}
