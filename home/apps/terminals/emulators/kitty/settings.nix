{ pkgs, ... }:
{
  programs.kitty = {
    font.name = "JetBrainsMono Nerd Font Mono";
    font.size = 12;
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;

      # Bottom tab
      tab_bar_min_tabs = 1;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "angled";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";

      # URLs
      open_url_with = "firefox";

      # Borders
      window_border_width = "3pt";
      window_margin_width = 0;

      # Four values set top, right, bottom and left.
      # For some reason there's more top padding, so we adjust for that
      window_padding_width = "10 15 15 15";

      # Cursor
      cursor_trail = 3;
      cursor_trail_decay =  "0.1 0.4";
      cursor_blink_interval = 0;

      # Other properties
      clipboard_control = "write-clipboard write-primary";
      allow_hyperlinks = true;

      # Include theme
      # include = ./themes/chiaroscuro.conf;
    };
  };
}
