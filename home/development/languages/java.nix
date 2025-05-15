# home/development/languages/java.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.java;
in
{
  options.home.development.languages.java = {
    enable = mkEnableOption "Enable Java development environment (Home Manager)";
    jdk = mkOption {
      type = types.package;
      default = pkgs.temurin-bin-17; # Example: Temurin JDK 17
      defaultText = "pkgs.temurin-bin-17";
      description = "The JDK package to use for home.packages.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Java Development Kit (JDK)
      cfg.jdk

      # Build Tools
      maven
      gradle

      # Language Server
      jdt-language-server
    ];
  };
}
