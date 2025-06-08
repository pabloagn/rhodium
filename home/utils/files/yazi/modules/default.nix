{ lib, pkgs, yaziPlugins, ... }:

let
  configBase = import ./base.nix { };
  configKeymaps = import ./keymap.nix { };
  luaConfig = import ./init-lua.nix { };
  configFiles = import ./files.nix { inherit pkgs; };
in
{
  programs.yazi = {
    settings = configBase;
    keymap = configKeymaps;
    initLua = luaConfig.initLua;
    plugins = yaziPlugins;
  };
  xdg.configFile = configFiles;
}
