# home/development/languages/cpp.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.cpp;
in
{
  options.rhodium.home.development.languages.cpp = {
    enable = mkEnableOption "Enable C++ development environment (Home Manager)";
    compilers = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        gcc
        clang
      ];
      description = "C++ compilers.";
    };

    buildTools = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        gnumake
        cmake
        meson
        ninja
      ];
      description = "Build system tools for C++.";
    };

    languageServers = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        clang-tools
      ];
      description = "Language servers for C++.";
    };

    linters = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        cppcheck
      ];
      description = "Linters and static analysis tools for C++.";
    };

    debuggers = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        gdb
        lldb
      ];
      description = "Debuggers for C++.";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Additional C++-related tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = cfg.compilers
      ++ cfg.buildTools
      ++ cfg.languageServers
      ++ cfg.linters
      ++ cfg.debuggers
      ++ cfg.extraTools;
  };
}
