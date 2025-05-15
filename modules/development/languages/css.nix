# modules/development/languages/css.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.css;
in
{
  options.modules.development.languages.css = {
    enable = mkEnableOption "Enable CSS development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Language Servers
      nodePackages.vscode-css-languageserver-bin # CSS, LESS, SCSS
      nodePackages."@tailwindcss/language-server" # If using Tailwind CSS

      # Linters
      nodePackages.stylelint
      # nodePackages.stylelint-config-standard # Example config for stylelint

      # Formatters
      nodePackages.prettier # Can format CSS
    ];
  };
}
