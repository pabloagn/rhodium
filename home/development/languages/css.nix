{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.css;
in
{
  options.home.development.languages.css = {
    enable = mkEnableOption "Enable CSS development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
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
