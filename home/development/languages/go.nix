# home/development/languages/go.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.go;
in
{
  options.rhodium.home.development.languages.go = {
    enable = mkEnableOption "Enable Go development environment (Home Manager)";
    compiler = mkOption {
      type = types.package;
      default = pkgs.go;
      description = "Go compiler and base toolchain (e.g., pkgs.go, pkgs.go_1_21).";
      example = literalExpression "pkgs.go_1_21";
    };

    languageServers = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        gopls
      ];
      description = "Go language servers.";
    };

    linters = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        golangci-lint
      ];
      description = "Go linters.";
    };

    formatters = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        gofumpt
        goimports-reviser
      ];
      description = "Go code formatters (go fmt is part of compiler).";
    };

    debuggers = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        delve
      ];
      description = "Go debuggers.";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Additional Go-related tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.compiler ]
      ++ cfg.languageServers
      ++ cfg.linters
      ++ cfg.formatters
      ++ cfg.debuggers
      ++ cfg.extraTools;
  };
}
