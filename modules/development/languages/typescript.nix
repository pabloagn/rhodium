# modules/development/languages/typescript.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.typescript;
in
{
  options.modules.development.languages.typescript = {
    enable = mkEnableOption "Enable TypeScript development environment";
  };

  config = mkIf cfg.enable {
    # TypeScript development typically requires Node.js
    # Ensure nodejs.nix is also enabled.
    environment.systemPackages = with pkgs; [
      # TypeScript Compiler and core tools
      nodePackages.typescript

      # Language Server
      nodePackages.typescript-language-server

      # Linters (ESLint with TypeScript plugins is common)
      nodePackages.eslint
      # nodePackages."@typescript-eslint/parser" # Parser for ESLint
      # nodePackages."@typescript-eslint/eslint-plugin" # Plugin for ESLint

      # Formatters
      nodePackages.prettier # Widely used for TypeScript formatting

      # Type definition manager (though often handled by npm/yarn/pnpm)
      # nodePackages.typesync # To keep @types/ packages in sync with package.json
    ];
  };
}
