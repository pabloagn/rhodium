# modules/development/languages/zig.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.zig;
in
{
  options.rhodium.system.development.languages.zig = {
    enable = mkEnableOption "Enable Zig development environment";
    # version = mkOption {
    #   type = types.nullOr types.str; # e.g. "0.11.0"
    #   default = null; # Uses pkgs.zig
    #   description = "Specify Zig version. If null, uses default pkgs.zig.";
    # };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Zig Compiler
      zig # Or specific versions like zig-master, zig_0_11_0 etc.
          # (if cfg.version == null then zig else pkgs."zig_${builtins.replaceStrings ["."] ["_"] cfg.version}")


      # Language Server
      zls # Zig Language Server
    ];
  };
}
