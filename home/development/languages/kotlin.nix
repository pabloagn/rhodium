# home/development/languages/kotlin.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.kotlin;
in
{
  options.rhodium.home.development.languages.kotlin = {
    enable = mkEnableOption "Enable Kotlin development environment (Home Manager)";

    jdk = mkOption {
      type = types.package;
      default = pkgs.temurin-bin-17;
      description = "The JDK package to use for Kotlin.";
      example = literalExpression "pkgs.temurin-bin-21";
    };

    compiler = mkOption {
      type = types.package;
      default = pkgs.kotlin;
      description = "Kotlin compiler.";
    };

    buildTools = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [ gradle ];
      description = "Build tools for Kotlin projects (e.g., gradle, maven).";
    };

    languageServer = mkOption {
      type = types.nullOr types.package;
      default = pkgs.kotlin-language-server;
      description = "Kotlin Language Server.";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Additional Kotlin-related tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.jdk
      cfg.compiler
    ]
    ++ cfg.buildTools
    ++ (if cfg.languageServer != null then [ cfg.languageServer ] else [ ])
    ++ cfg.extraTools;
  };
}
