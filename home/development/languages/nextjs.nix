# home/development/languages/nextjs.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.nextjs;
in
{
  options.rhodium.home.development.languages.nextjs = {
    enable = mkEnableOption "Enable Next.js global tools (Home Manager)";

    cliTools = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Global CLI tools for Next.js (project setup is usually per-project).";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Additional global Next.js-related tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = cfg.cliTools
      ++ cfg.extraTools;
  };
}
