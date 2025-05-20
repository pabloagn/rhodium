# home/development/languages/zig.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.zig;
in
{
  options.rhodium.home.development.languages.zig = {
    enable = mkEnableOption "Enable Zig development environment (Home Manager)";

    compiler = mkOption {
      type = types.package;
      default = pkgs.zig;
      description = "Zig compiler and toolchain.";
    };

    languageServer = mkOption {
      type = types.package;
      default = pkgs.zls;
      description = "Zig Language Server.";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Additional Zig-related tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.compiler
      cfg.languageServer
    ]
    ++ cfg.extraTools;
  };
}
