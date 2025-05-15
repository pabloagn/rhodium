# home/development/languages/cpp.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.cpp;
in
{
  options.home.development.languages.cpp = {
    enable = mkEnableOption "Enable C++ development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Compilers
      gcc # Provides g++
      clang # Provides clang++

      # Build Tools
      gnumake
      cmake
      meson
      ninja

      # Language Server
      clang-tools # Provides clangd and clang-tidy

      # Linters / Static Analysis
      cppcheck
      # clang-tidy is part of clang-tools

      # Debugger
      gdb
      lldb # Part of llvmPackages.lldb
    ];
  };
}
