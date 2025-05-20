# home/development/languages/swift.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.swift;
in
{
  options.rhodium.home.development.languages.swift = {
    enable = mkEnableOption "Enable Swift development environment (Home Manager)";

    compiler = mkOption {
      type = types.package;
      default = pkgs.swift;
      description = "Swift compiler and toolchain.";
    };

    languageServer = mkOption {
      type = types.nullOr types.package;
      default = null;
      description = "Swift Language Server (e.g., SourceKit-LSP). May require manual setup or specific nixpkgs attribute.";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Additional Swift-related tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.compiler ]
      ++ (if cfg.languageServer != null then [ cfg.languageServer ] else [ ])
      ++ cfg.extraTools;
  };
}
