{
  lib,
  pkgs,
  yaziPlugins,
  ...
}: let
  configBase = import ./base.nix {};
  configKeymaps = import ./keymap.nix {};
  configFiles = import ./files.nix {inherit pkgs;};
  initLua = import ../plugins {inherit lib;};
  # theme = import ./tokyonight.nix {};
  theme = import ./kanso.nix {};
in {
  programs.yazi = {
    settings = configBase;
    theme = theme;
    keymap = configKeymaps;
    initLua = initLua;
    plugins = yaziPlugins;
  };
  xdg.configFile = configFiles;
}
