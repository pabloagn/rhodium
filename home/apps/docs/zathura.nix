{ pkgs, theme, ... }:
{
  programs.zathura = {
    enable = true;

    options = {
      # --- Performance ---
      render-loading = true;
      render-loading-bg = theme.colors.bg or "#1a1a2e";
      render-loading-fg = theme.colors.fg or "#c8c8d0";
      page-cache-size = 50; # Cache more pages for faster navigation
      pages-per-row = 1;
      scroll-page-aware = true;
      scroll-full-overlap = "0.01";
      scroll-step = 100;

      # --- UI & Appearance ---
      font = "${theme.fonts.mono or "JetBrainsMono Nerd Font"} 11";
      statusbar-home-tilde = true;
      window-title-home-tilde = true;
      window-title-basename = true;
      guioptions = "shv"; # Show statusbar, horizontal/vertical scrollbars

      # --- Search ---
      incremental-search = true;
      nohlsearch = false; # Keep search highlights visible

      # --- Clipboard ---
      selection-clipboard = "clipboard"; # Use system clipboard for selections
      selection-notification = true;

      # --- Zoom ---
      zoom-min = 10;
      zoom-max = 1000;
      zoom-step = 10;
      adjust-open = "best-fit";

      # --- Colors (using theme) ---
      default-bg = theme.colors.bg or "#1a1a2e";
      default-fg = theme.colors.fg or "#c8c8d0";
      statusbar-bg = theme.colors.bg_dark or "#141420";
      statusbar-fg = theme.colors.fg or "#c8c8d0";
      inputbar-bg = theme.colors.bg or "#1a1a2e";
      inputbar-fg = theme.colors.fg or "#c8c8d0";
      notification-bg = theme.colors.bg or "#1a1a2e";
      notification-fg = theme.colors.green or "#87a987";
      notification-error-bg = theme.colors.bg or "#1a1a2e";
      notification-error-fg = theme.colors.red or "#c4746e";
      notification-warning-bg = theme.colors.bg or "#1a1a2e";
      notification-warning-fg = theme.colors.yellow or "#c4b28a";
      highlight-color = theme.colors.yellow or "#c4b28a";
      highlight-active-color = theme.colors.green or "#87a987";
      completion-bg = theme.colors.bg_dark or "#141420";
      completion-fg = theme.colors.fg or "#c8c8d0";
      completion-highlight-bg = theme.colors.blue or "#8ba4b0";
      completion-highlight-fg = theme.colors.bg or "#1a1a2e";
      completion-group-bg = theme.colors.bg_dark or "#141420";
      completion-group-fg = theme.colors.blue or "#8ba4b0";
      index-bg = theme.colors.bg or "#1a1a2e";
      index-fg = theme.colors.fg or "#c8c8d0";
      index-active-bg = theme.colors.blue or "#8ba4b0";
      index-active-fg = theme.colors.bg or "#1a1a2e";

      # --- Recolor (dark mode for PDFs) ---
      recolor = false; # Don't recolor by default
      recolor-keephue = true;
      recolor-darkcolor = theme.colors.fg or "#c8c8d0";
      recolor-lightcolor = theme.colors.bg or "#1a1a2e";
      recolor-reverse-video = true;
    };

    mappings = {
      # Navigation
      "<C-d>" = "scroll half-down";
      "<C-u>" = "scroll half-up";
      "D" = "toggle_page_mode";
      "r" = "rotate rotate-cw";
      "R" = "rotate rotate-ccw";
      "K" = "zoom in";
      "J" = "zoom out";
      "i" = "recolor"; # Toggle dark mode
      "<C-r>" = "reload";
      "p" = "print";
      "b" = "toggle_statusbar";
      "<C-c>" = "abort";

      # Bookmarks
      "m" = "mark_evaluate";
      "'" = "mark_evaluate";

      # Index (table of contents)
      "<Tab>" = "toggle_index";
    };

    extraConfig = ''
      # Additional settings
      set database sqlite
      set sandbox normal
      set page-padding 2
      set show-recent 20
      set first-page-column 1
    '';
  };
}
