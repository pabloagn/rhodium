# home/development/languages/python.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.python;
in
{
  options.rhodium.home.development.languages.python = {
    enable = mkEnableOption "Enable Python development environment (Home Manager)";

    variants = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        python311
        python312
      ];
      description = "List of Python interpreter packages to install.";
      example = literalExpression "[ pkgs.python311 pkgs.python310 ]";
    };

    linters = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        ruff
        mypy
        debugpy
        black
      ];
      description = "List of linters to install";
      example = literalExpression "[ pkgs.ruff pkgs.black ]";
    };

    packageManagers = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        poetry
        pdm
      ];
      description = "Python package management tools.";
    };

    languageServers = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        pyright
      ];
      description = "Python language servers.";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Additional Python-related tools to install.";
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      cfg.variants
      ++ cfg.linters
      ++ cfg.packageManagers
      ++ cfg.languageServers
      ++ cfg.extraTools;
  };
}
