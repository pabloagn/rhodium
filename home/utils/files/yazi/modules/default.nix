{
  lib,
  pkgs,
  pkgs-unstable,
  yaziPlugins,
  ...
}: let
  configBase = import ./base.nix {};
  # configKeymaps = import ./keymap.nix {};
  configFiles = import ./files.nix {inherit pkgs;};
  initLua = import ../plugins {inherit lib;};
  # theme = import ./tokyonight.nix {};
  theme = import ./kanso.nix {};
in {
  programs.yazi = {
    settings = configBase;
    theme = theme;
    # keymap = configKeymaps;
    initLua = initLua;
    # plugins = yaziPlugins;
    plugins = {
      yatline = pkgs.yaziPlugins.yatline;
      git = pkgs-unstable.yaziPlugins.git;
      yatline-githead = pkgs-unstable.yaziPlugins.yatline-githead;
      chmod = pkgs.yaziPlugins.chmod;
      full-border = pkgs.yaziPlugins.full-border;
      toggle-pane = pkgs.yaziPlugins.toggle-pane;
      smart-filter = pkgs.yaziPlugins.smart-filter;
      smart-enter = pkgs.yaziPlugins.smart-enter;
      smart-paste = pkgs.yaziPlugins.smart-paste;
    };
  };
  xdg.configFile = configFiles;
}
