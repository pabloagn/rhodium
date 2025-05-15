# home/development/languages/kotlin.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.kotlin;
in
{
  options.home.development.languages.kotlin = {
    enable = mkEnableOption "Enable Kotlin development environment (Home Manager)";
    jdk = mkOption {
      type = types.package;
      default = pkgs.temurin-bin-17; # Kotlin runs on JVM
      defaultText = "pkgs.temurin-bin-17";
      description = "The JDK package to use for Kotlin (home.packages).";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Kotlin Compiler
      kotlin

      # JDK (required for Kotlin)
      cfg.jdk

      # Build Tools (Gradle is common, Maven can also be used)
      gradle # Often used for Kotlin projects

      # Language Server
      kotlin-language-server
    ];
  };
}
