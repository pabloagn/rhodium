{...}: {
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    settings = {
      auto_sync = false;
      sync_enabled = false;
      search_mode = "fuzzy";
      filter_mode = "global";
      style = "full";
      show_preview = true;
      show_help = false;
      show_tabs = true;
      inline_height = 25;
      max_preview_height = 10;
      keymap_mode = "vim-insert";
      invert = false;
      enter_accept = false;
      exit_mode = "return-original";
    };
  };
}
