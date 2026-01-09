{
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
let
  configBase = import ./base.nix { };
  configKeymaps = import ./keymap.nix { };
  configFiles = import ./files.nix { inherit pkgs; };
  initLua = import ../plugins { inherit lib; };
  theme = import ./kanso.nix { };
in
{
  programs.yazi = {
    settings = configBase;
    theme = theme;
    keymap = configKeymaps;
    initLua = initLua;
    plugins = {
      chmod = pkgs.yaziPlugins.chmod;
      diff = pkgs.yaziPlugins.diff;
      duckdb = pkgs.yaziPlugins.duckdb;
      full-border = pkgs.yaziPlugins.full-border;
      git = pkgs-unstable.yaziPlugins.git;
      miller = pkgs.yaziPlugins.miller;
      mediainfo = pkgs.yaziPlugins.mediainfo;
      mount = pkgs.yaziPlugins.mount;
      piper = pkgs.yaziPlugins.piper;
      projects = pkgs.yaziPlugins.projects;
      restore = pkgs.yaziPlugins.restore;
      sudo = pkgs.yaziPlugins.sudo;
      smart-enter = pkgs.yaziPlugins.smart-enter;
      smart-filter = pkgs.yaziPlugins.smart-filter;
      smart-paste = pkgs.yaziPlugins.smart-paste;
      toggle-pane = pkgs.yaziPlugins.toggle-pane;
      # yatline = pkgs.yaziPlugins.yatline;  # Disabled: uses deprecated ya.truncate()
      # yatline-githead = pkgs-unstable.yaziPlugins.yatline-githead;  # Disabled: depends on yatline
    };
  };
  xdg.configFile = configFiles;
}
