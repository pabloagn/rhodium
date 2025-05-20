# home/development/languages/lua.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.lua;
in
{
  options.rhodium.home.development.languages.lua = {
    enable = mkEnableOption "Enable Lua development environment (Home Manager)";

    interpreter = mkOption {
      type = types.package;
      default = pkgs.lua54;
      description = "The Lua interpreter package (e.g., lua51, lua54, luajit).";
      example = literalExpression "pkgs.luajit";
    };

    languageServer = mkOption {
      type = types.package;
      default = pkgs.lua-language-server;
      description = "Lua Language Server.";
    };

    linter = mkOption {
      type = types.package;
      default = pkgs.luacheck;
      description = "Lua linter.";
    };

    formatter = mkOption {
      type = types.package;
      default = pkgs.stylua;
      description = "Lua code formatter.";
    };

    packageManager = mkOption {
      type = types.package;
      default = pkgs.luarocks;
      description = "Lua package manager.";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Additional Lua-related tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.interpreter
      cfg.languageServer
      cfg.linter
      cfg.formatter
      cfg.packageManager
    ] ++ cfg.extraTools;
  };
}
