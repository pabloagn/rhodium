# modules/development/languages/scala.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.scala;
in
{
  options.rhodium.system.development.languages.scala = {
    enable = mkEnableOption "Enable Scala development environment";
    jdk = mkOption {
      type = types.package;
      default = pkgs.temurin-bin-17; # Scala runs on JVM
      defaultText = "pkgs.temurin-bin-17";
      description = "The JDK package to use for Scala.";
    };
    scalaVersion = mkOption {
      type = types.package;
      default = pkgs.scala_3; # Example: Scala 3
      defaultText = "pkgs.scala_3";
      description = "The Scala package to use (e.g., scala_2_13, scala_3).";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Scala Compiler and standard library
      cfg.scalaVersion

      # JDK (required for Scala)
      cfg.jdk

      # Build Tool
      sbt # Scala Build Tool

      # Language Server
      metals

      # Formatter (Scalafmt is often run via sbt or Metals)
      # scalafmt # If a standalone CLI is desired
    ];
  };
}
