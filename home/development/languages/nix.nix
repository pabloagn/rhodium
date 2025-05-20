# home/development/languages/nix.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.nix;
in
{
  options.rhodium.home.development.languages.nix = {
    enable = mkEnableOption "Enable Nix development tools (Home Manager)";

    languageServers = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        nil
      ];
      description = "Nix language servers.";
    };

    formatters = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        nixpkgs-fmt
        alejandra
      ];
      description = "Nix code formatters.";
    };

    utilityTools = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        cachix
        nix-info
        sbomnix
      ];
      description = "General Nix utility tools.";
    };

    analysisTools = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        statix
        deadnix
        nix-tree
        nix-du
      ];
      description = "Nix code analysis and inspection tools.";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = [];
      description = "Additional Nix-related tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = cfg.languageServers
      ++ cfg.formatters
      ++ cfg.utilityTools
      ++ cfg.analysisTools
      ++ cfg.extraTools;
  };
}
