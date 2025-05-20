# home/development/languages/scala.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.scala;
in
{
  options.rhodium.home.development.languages.scala = {
    enable = mkEnableOption "Enable Scala development environment (Home Manager)";

    jdk = mkOption {
      type = types.package;
      default = pkgs.temurin-bin-17;
      description = "The JDK package to use for Scala.";
      example = literalExpression "pkgs.temurin-bin-21";
    };

    scalaVersion = mkOption {
      type = types.package;
      default = pkgs.scala_3;
      description = "The Scala compiler package (e.g., scala_2_12, scala_2_13, scala_3).";
      example = literalExpression "pkgs.scala_2_13";
    };

    buildTool = mkOption {
      type = types.package;
      default = pkgs.sbt;
      description = "Scala build tool (e.g., sbt, mill).";
      example = literalExpression "pkgs.mill";
    };

    languageServer = mkOption {
      type = types.package;
      default = pkgs.metals;
      description = "Scala language server (Metals).";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Additional Scala-related tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.jdk
      cfg.scalaVersion
      cfg.buildTool
      cfg.languageServer
    ] ++ cfg.extraTools;
  };
}
