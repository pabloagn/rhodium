# home/development/languages/lua.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.lua;
in
{
  options.home.development.languages.lua = {
    enable = mkEnableOption "Enable Lua development environment (Home Manager)";
    luaPackage = mkOption {
      type = types.package;
      default = pkgs.lua54;
      defaultText = "pkgs.lua54";
      description = "The Lua interpreter package (e.g., lua51, lua52, lua53, lua54, luajit).";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Lua Interpreter
      cfg.luaPackage

      # Language Server
      lua-language-server # (sumneko_lua)

      # Linter
      luacheck

      # Formatter
      stylua

      # Package Manager
      luarocks
    ];
  };
}
