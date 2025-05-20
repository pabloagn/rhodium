# home/development/languages/reactjs.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.reactjs;
in
{
  options.rhodium.home.development.languages.reactjs = {
    enable = mkEnableOption "Enable React.js global tools (Home Manager)";

    cliTools = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "Global CLI tools for React.js (project setup is usually per-project).";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "Additional global React.js-related tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = cfg.cliTools
      ++ cfg.extraTools;
  };
}
