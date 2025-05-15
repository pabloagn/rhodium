# modules/development/languages/kotlin.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.kotlin;
in
{
  options.modules.development.languages.kotlin = {
    enable = mkEnableOption "Enable Kotlin development environment";
    jdk = mkOption {
      type = types.package;
      default = pkgs.temurin-bin-17; # Kotlin runs on JVM
      defaultText = "pkgs.temurin-bin-17";
      description = "The JDK package to use for Kotlin.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
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
