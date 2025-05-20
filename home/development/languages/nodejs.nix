# home/development/languages/nodejs.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.nodejs;
in
{
  options.rhodium.home.development.languages.nodejs = {
    enable = mkEnableOption "Enable Node.js development environment (Home Manager)";

    runtime = mkOption {
      type = types.package;
      default = pkgs.nodejs_20;
      description = "The Node.js runtime package (e.g., nodejs_20, nodejs_18).";
      example = literalExpression "pkgs.nodejs_18";
    };

    packageManagers = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [ yarn pnpm ];
      description = "Additional Node.js package managers (npm is included with Node.js).";
    };

    corepack = mkOption {
      type = types.bool;
      default = true;
      description = "Ensure corepack is available/enabled for managing package manager versions.";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Additional global Node.js-related tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.runtime ]
      ++ cfg.packageManagers
      ++ (if cfg.corepack && pkgs ? corepack then [ pkgs.corepack ] else [ ])
      ++ cfg.extraTools;
  };
}
