{ ... }:

{
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    settings = {
      auto_sync = false;
      sync_enabled = false;
      search_mode = "fuzzy";
      filter_mode = "global";
      style = "compact";
      show_preview = true;
      show_help = false;
      inline_height = 10;
      keymap_mode = "vim-normal";
    };
  };
}
