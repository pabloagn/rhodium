{ pkgs, yaziPlugins, ... }:

let
  # Main config
  configBase = import ./base.nix { };
  configKeymaps = import ./keymap.nix { };
  configPlugins = import ./plugins.nix { inherit yaziPlugins; };

  # init.lua
  luaConfig = import ./init-lua.nix { };

  # Additional non-declarative config files
  configFiles = import ./files.nix { inherit pkgs; };
in
{
  programs.yazi = {
    settings = configBase;
    keymap = configKeymaps;
    plugins = configPlugins;
    initLua = luaConfig.initLua;
  };

  xdg.configFile = configFiles;
}
