{ pkgs, ... }:

let
  luaConfig = import ./init-lua.nix;
  configFiles = import ./files.nix { inherit pkgs; };
in
{
  programs.yazi = {
    initLua = luaConfig.initLua;
  };

  xdg.configFile = configFiles;
}
