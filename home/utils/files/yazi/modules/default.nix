{ pkgs, yaziPlugins, ... }:

let
  # Main config
  configBase = import ./base { };
  configKeymaps = import ./keymap.nix { };
  configPlugins = import ./plugins.nix { inherit yaziPlugins; };

  # init.lua
  luaConfig = import ./init-lua.nix { };

  # Additional non-declarative config files
  configFiles = import ./files.nix { inherit pkgs; };
in
{
  imports = [
    ./plugins.nix { inherit yaziPlugins; } 
  ];
  
  programs.yazi = {
    settings = configBase;
    keymap = configKeymaps;
    plugins = configPlugins;
    initLua = luaConfig.initLua;
  };

  xdg.configFile = configFiles;
}
