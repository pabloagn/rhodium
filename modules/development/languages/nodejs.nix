# modules/development/languages/nodejs.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.nodejs;
in
{
  options.rhodium.system.development.languages.nodejs = {
    enable = mkEnableOption "Enable Node.js development environment";
    package = mkOption {
      type = types.package;
      default = pkgs.nodejs_20; # Example: Node.js 20
      defaultText = "pkgs.nodejs_20";
      description = "The Node.js package to use (e.g., nodejs, nodejs_20, nodejs_18).";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Node.js (includes npm)
      cfg.package

      # Additional Package Managers
      yarn
      pnpm

      # Corepack for managing package manager versions (comes with newer Node.js)
      # corepack # (if not bundled or to ensure it's enabled)
    ];
  };
}
