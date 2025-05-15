# home/development/languages/zig.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.zig;
in
{
  options.home.development.languages.zig = {
    enable = mkEnableOption "Enable Zig development environment (Home Manager)";
    # version = mkOption {
    #   type = types.nullOr types.str; # e.g. "0.11.0"
    #   default = null; # Uses pkgs.zig
    #   description = "Specify Zig version for home.packages. If null, uses default pkgs.zig.";
    # };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Zig Compiler
      zig # Or specific versions like zig-master, zig_0_11_0 etc.
          # (if cfg.version == null then zig else pkgs."zig_${builtins.replaceStrings ["."] ["_"] cfg.version}")

      # Language Server
      zls # Zig Language Server
    ];
  };
}
