{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.html;
in
{
  options.home.development.languages.html = {
    enable = mkEnableOption "Enable HTML development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Language Server
      nodePackages.vscode-html-languageserver-bin

      # Linters
      # nodePackages.htmlhint # A popular HTML linter

      # Formatters
      nodePackages.prettier # Can format HTML
    ];
  };
}
