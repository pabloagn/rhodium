# home/development/languages/typescript.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.typescript;
in
{
  options.rhodium.home.development.languages.typescript = {
    enable = mkEnableOption "Enable TypeScript development environment (Home Manager)";

    compiler = mkOption {
      type = types.package;
      default = pkgs.nodePackages.typescript;
      description = "TypeScript compiler.";
    };

    languageServer = mkOption {
      type = types.package;
      default = pkgs.nodePackages.typescript-language-server;
      description = "TypeScript Language Server.";
    };

    linters = mkOption {
      type = types.listOf types.package;
      default = with pkgs.nodePackages; [
        eslint
        "@typescript-eslint/parser"
        "@typescript-eslint/eslint-plugin"
      ];
      description = "Linters for TypeScript (typically ESLint with TS plugins).";
    };

    formatters = mkOption {
      type = types.listOf types.package;
      default = with pkgs.nodePackages; [
        prettier
      ];
      description = "Code formatters for TypeScript.";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Additional TypeScript-related tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.compiler cfg.languageServer ]
      ++ cfg.linters
      ++ cfg.formatters
      ++ cfg.extraTools;
  };
}
