# modules/development/languages/html.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.html;
in
{
  options.modules.development.languages.html = {
    enable = mkEnableOption "Enable HTML development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Language Server
      nodePackages.vscode-html-languageserver-bin

      # Linters
      # nodePackages.htmlhint # A popular HTML linter

      # Formatters
      nodePackages.prettier # Can format HTML
    ];
  };
}
