{ pkgs, ... }:

let
  plugins = import ./plugins.nix { inherit pkgs; };
  luaConfig = import ./init-lua.nix;
  configFiles = import ./files.nix { inherit pkgs; };
in
{
  programs.yazi = {
    plugins = plugins;
    initLua = luaConfig.initLua;
  };

  xdg.configFile = configFiles;
}
