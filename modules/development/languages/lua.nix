# modules/development/languages/lua.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.lua;
in
{
  options.modules.development.languages.lua = {
    enable = mkEnableOption "Enable Lua development environment";
    luaVersion = mkOption {
      type = types.enum [ "lua51" "lua52" "lua53" "lua54" "luajit" ];
      default = "lua54";
      description = "Version of Lua to install.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Lua Interpreter
      (getAttr cfg.luaVersion pkgs)

      # Language Server
      lua-language-server # (sumneko_lua)

      # Linter
      luacheck

      # Formatter
      stylua

      # Package Manager (optional, if needed system-wide)
      # luarocks
    ];
  };
}
