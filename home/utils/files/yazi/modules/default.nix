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
      # --- Core Functionality ---
      chmod = pkgs-unstable.yaziPlugins.chmod;
      diff = pkgs-unstable.yaziPlugins.diff;
      sudo = pkgs-unstable.yaziPlugins.sudo;
      restore = pkgs-unstable.yaziPlugins.restore;

      # --- Navigation & Productivity ---
      smart-enter = pkgs-unstable.yaziPlugins.smart-enter;
      smart-filter = pkgs-unstable.yaziPlugins.smart-filter;
      smart-paste = pkgs-unstable.yaziPlugins.smart-paste;
      jump-to-char = pkgs-unstable.yaziPlugins.jump-to-char;
      relative-motions = pkgs-unstable.yaziPlugins.relative-motions;
      projects = pkgs-unstable.yaziPlugins.projects;

      # --- UI & Visual ---
      full-border = pkgs-unstable.yaziPlugins.full-border;
      toggle-pane = pkgs-unstable.yaziPlugins.toggle-pane;

      # --- Git Integration ---
      git = pkgs-unstable.yaziPlugins.git;
      lazygit = pkgs-unstable.yaziPlugins.lazygit;

      # --- File Preview ---
      duckdb = pkgs-unstable.yaziPlugins.duckdb;
      miller = pkgs-unstable.yaziPlugins.miller;
      glow = pkgs-unstable.yaziPlugins.glow;
      piper = pkgs-unstable.yaziPlugins.piper;
      mediainfo = pkgs-unstable.yaziPlugins.mediainfo;
      rich-preview = pkgs-unstable.yaziPlugins.rich-preview;

      # --- Archive & Compression ---
      ouch = pkgs-unstable.yaziPlugins.ouch;
      compress = pkgs-unstable.yaziPlugins.compress;

      # --- System & Utilities ---
      mount = pkgs-unstable.yaziPlugins.mount;
      mime-ext = pkgs-unstable.yaziPlugins.mime-ext;

      # --- Clipboard (Wayland) ---
      wl-clipboard = pkgs-unstable.yaziPlugins.wl-clipboard;
    };
  };
  xdg.configFile = configFiles;
}
