# modules/development/languages/java.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.java;
in
{
  options.modules.development.languages.java = {
    enable = mkEnableOption "Enable Java development environment";
    jdk = mkOption {
      type = types.package;
      default = pkgs.temurin-bin-17; # Example: Temurin JDK 17
      defaultText = "pkgs.temurin-bin-17";
      description = "The JDK package to use.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
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
