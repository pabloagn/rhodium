# home/development/languages/python.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.python;
in
{
  options.home.development.languages.python = {
    enable = mkEnableOption "Enable Python development environment (Home Manager)";
    pythonPackage = mkOption {
      type = types.package;
      default = pkgs.python3;
      defaultText = "pkgs.python3";
      description = "The Python interpreter package for home.packages (e.g., python3, python311, python310).";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Python Interpreter
      cfg.pythonPackage

      # Package Management
      poetry
      pdm

      # Language Servers
      pyright

      # Linters & Formatters
      ruff
      # black
      mypy

      # Debugger
      debugpy
    ];
  };
}
