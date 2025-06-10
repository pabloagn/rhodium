{ lib, pkgs, yaziPlugins, ... }:

let
  configBase = import ./base.nix { };
  configKeymaps = import ./keymap.nix { };
  configFiles = import ./files.nix { inherit pkgs; };
  initLua = import ../plugins { };
  theme = import ./theme.nix { };
in
{
  programs.yazi = {
    settings = configBase;
    theme = theme;
    keymap = configKeymaps;
    initLua = initLua;
    plugins = yaziPlugins;
  };
  xdg.configFile = configFiles;
}

