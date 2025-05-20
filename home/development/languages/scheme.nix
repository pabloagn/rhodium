# home/development/languages/scheme.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.scheme;
in
{
  options.rhodium.home.development.languages.scheme = {
    enable = mkEnableOption "Enable Scheme development environment (Home Manager)";

    interpretersCompilers = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        guile
        chicken
        chezscheme
      ];
      description = "Scheme interpreters and compilers.";
      example = literalExpression "[ pkgs.guile pkgs.mit-scheme ]";
    };

    languageServer = mkOption {
      type = types.nullOr types.package;
      default = null;
      description = "Scheme Language Server (if available in nixpkgs).";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Additional Scheme-related tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = cfg.interpretersCompilers
      ++ (if cfg.languageServer != null then [ cfg.languageServer ] else [ ])
      ++ cfg.extraTools;
  };
}
