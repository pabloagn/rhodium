{ ... }:
{
  programs.kitty = {
    font.name = "BerkeleyMonoRh Nerd Font";
    font.size = 12;

    settings = {
      # Font configurations for bold/italic variants
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      # Force Nerd Font icons to use Symbols Nerd Font Mono for consistent single-cell width.
      # Fixes inconsistent icon sizes in Yazi, Neovim Telescope, and other TUI apps.
      symbol_map = "U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E6B5,U+E700-U+E7C5,U+EA60-U+EC1E,U+ED00-U+EFCE,U+F000-U+F2FF,U+F300-U+F372,U+F400-U+F533,U+F0001-U+F1AF0 Symbols Nerd Font Mono";

      allow_remote_control = true;
      scrollback_lines = 10000;
      enable_audio_bell = false;

      # --- Bottom Tab ---
      tab_bar_min_tabs = 2; # Only enable for tab num >= 2
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "angled";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";

      # --- Urls ---
      open_url_with = "firefox -p Personal";

      # Borders
      window_border_width = "3pt";
      window_margin_width = 0;

      # Four values set top, right, bottom and left.
      # For some reason there's more top padding, so we adjust for that
      window_padding_width = "10 15 15 15";

      # Cursor
      # cursor_trail = 3;
      # cursor_trail_decay = "0.1 0.4";
      # cursor_trail = 2;
      # cursor_trail_decay = "0.1 0.2";
      cursor_blink_interval = 0;

      # Other properties
      clipboard_control = "write-clipboard write-primary";
      allow_hyperlinks = true;
    };
  };
}
