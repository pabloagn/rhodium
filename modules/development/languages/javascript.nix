# modules/development/languages/javascript.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.javascript;
in
{
  options.modules.development.languages.javascript = {
    enable = mkEnableOption "Enable JavaScript development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Node.js (Runtime for JS, often includes npm)
      nodejs # Or a specific version like nodejs_20

      # Package Managers (npm comes with nodejs)
      yarn
      pnpm

      # Language Server (TypeScript server works well for JS too)
      nodePackages.typescript-language-server
      # Alternatively, for ESLint integration:
      # nodePackages.eslint_d # ESLint daemon as LSP

      # Linters
      nodePackages.eslint

      # Formatters
      nodePackages.prettier
    ];
  };
}
