# modules/development/languages/c.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.c;
in
{
  options.modules.development.languages.c = {
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
      # autoconf
      # automake

      # Language Server
      clang-tools # Provides clangd

      # Linters / Static Analysis
      cppcheck # Can be used for C

      # Debugger
      gdb
    ];
  };
}
