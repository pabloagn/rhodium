# home/development/languages/c.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.c;
in
{
  options.home.development.languages.c = {
    enable = mkEnableOption "Enable C development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
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
