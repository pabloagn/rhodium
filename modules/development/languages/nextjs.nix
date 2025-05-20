# modules/development/languages/nextjs.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.nextjs;
in
{
  options.rhodium.system.development.languages.nextjs = {
    enable = mkEnableOption "Enable Next.js development environment";
  };

  config = mkIf cfg.enable {
    # Next.js relies heavily on Node.js, TypeScript/JavaScript.
    # Ensure nodejs.nix and typescript.nix (if using TS) are also enabled.
    environment.systemPackages = [
      # Next.js CLI (usually installed per project, but can be global)
      # nodePackages.next # For `create-next-app` and other commands

      # Core dependencies like Node.js are expected to be provided by nodejs.nix
      # LSPs/Linters/Formatters are expected from javascript.nix/typescript.nix
    ];
  };
}
