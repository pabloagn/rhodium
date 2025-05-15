# home/development/languages/javascript.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.javascript;
in
{
  options.home.development.languages.javascript = {
    enable = mkEnableOption "Enable JavaScript development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Node.js (Runtime for JS, often includes npm)
      # This is often managed by nodejs.nix, but can be included if a specific version is needed here
      # nodejs # Or a specific version like nodejs_20

      # Package Managers (npm comes with nodejs if nodejs is included here)
      # yarn
      # pnpm

      # Language Server (TypeScript server works well for JS too)
      nodePackages.typescript-language-server
      # Alternatively, for ESLint integration:
      # nodePackages.eslint_d # ESLint daemon as LSP

      # Linters
      nodePackages.eslint

      # Formatters
      nodePackages.prettier
    ];
    # Note: Node.js itself is best managed via home.development.languages.nodejs
  };
}
