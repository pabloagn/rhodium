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
      chmod = pkgs-unstable.yaziPlugins.chmod;
      diff = pkgs-unstable.yaziPlugins.diff;
      duckdb = pkgs-unstable.yaziPlugins.duckdb;
      full-border = pkgs-unstable.yaziPlugins.full-border;
      git = pkgs-unstable.yaziPlugins.git;
      glow = pkgs-unstable.yaziPlugins.glow;
      miller = pkgs-unstable.yaziPlugins.miller;
      mediainfo = pkgs-unstable.yaziPlugins.mediainfo;
      mount = pkgs-unstable.yaziPlugins.mount;
      piper = pkgs-unstable.yaziPlugins.piper;
      projects = pkgs-unstable.yaziPlugins.projects;
      restore = pkgs-unstable.yaziPlugins.restore;
      sudo = pkgs-unstable.yaziPlugins.sudo;
      smart-enter = pkgs-unstable.yaziPlugins.smart-enter;
      smart-filter = pkgs-unstable.yaziPlugins.smart-filter;
      smart-paste = pkgs-unstable.yaziPlugins.smart-paste;
      toggle-pane = pkgs-unstable.yaziPlugins.toggle-pane;
    };
  };
  xdg.configFile = configFiles;
}
