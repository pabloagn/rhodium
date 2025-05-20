# modules/development/languages/c.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.c;
in
{
  options.rhodium.system.development.languages.c = {
    enable = mkEnableOption "Enable C development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Compilers
      gcc
      clang

      # Build Tools
      gnumake
      cmake

      # Language Server
      clang-tools

      # Linters / Static Analysis
      cppcheck

      # Debugger
      gdb
    ];
  };
}
