# modules/development/languages/python.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.python;
in
{
  options.modules.development.languages.python = {
    enable = mkEnableOption "Enable Python development environment";
    pythonPackage = mkOption {
      type = types.package;
      default = pkgs.python3; # Defaults to python3 from nixpkgs
      defaultText = "pkgs.python3";
      description = "The Python interpreter package (e.g., python3, python311, python310).";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Python Interpreter
      cfg.pythonPackage

      # Package Management (pip is usually included with Python)
      # poetry # Popular dependency manager
      # pdm # Another modern Python package manager

      # Language Servers
      pyright # Fast type checker and language server by Microsoft
      # python-lsp-server # (pylsp) Community-maintained, plugin-based

      # Linters & Formatters
      ruff # Extremely fast linter and formatter
      # black # The uncompromising Python code formatter
      # flake8 # Linter (can be replaced by ruff)
      # mypy # Optional static type checker

      # Debugger
      # debugpy # For debugging with VSCode and other editors
    ];
  };
}
