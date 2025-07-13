{ ... }:
{
  services.dunst = {
    enable = false;
    settings = {
      global = {
        # Geometry and positioning
        width = "(200, 400)";
        height = 120;
        offset = "20x20";
        origin = "top-right";

        frame_width = 1;
        frame_color = "#3c3c3c";
        separator_color = "#3c3c3c";
        separator_height = 1;

        # Typography
        font = "JetBrains Mono Nerd Font 10";

        # Spacing
        padding = 8;
        horizontal_padding = 12;
        text_icon_padding = 8;

        # Terminal-inspired behavior
        sort = true;
        indicate_hidden = true;
        show_age_threshold = 60;
        stack_duplicates = true;
        hide_duplicate_count = false;

        # Timing
        idle_threshold = 120;
        sticky_history = true;
        history_length = 20;

        # Additional formatting
        word_wrap = true;
        ellipsize = "middle";
        ignore_newline = false;
        show_indicators = false;

        # Prompt
        format = "<b>▶ %s</b>\n%b";

        corner_radius = 0;
        progress_bar = true;
        progress_bar_height = 8;
        progress_bar_frame_width = 0;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;

        highlight = "#ffffff";

        # Mouse interaction
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };

      # Low priority notifications - subdued
      urgency_low = {
        background = "#1a1a1a";
        foreground = "#888888";
        frame_color = "#2a2a2a";
        timeout = 8;
      };

      # Normal notifications - primary interface
      urgency_normal = {
        background = "#2a2a2a";
        foreground = "#ffffff";
        frame_color = "#3c3c3c";
        timeout = 10;
      };

      # Critical notifications - demanding attention
      urgency_critical = {
        background = "#3a3a3a";
        foreground = "#ffffff";
        frame_color = "#555555";
        timeout = 0; # Stay until dismissed
      };

      # Special application overrides
      telegram = {
        appname = "telegram";
        background = "#1e1e1e";
        foreground = "#cccccc";
        frame_color = "#333333";
        format = "<b>▶ %s</b>\n%b";
      };

      discord = {
        appname = "discord";
        background = "#1e1e1e";
        foreground = "#cccccc";
        frame_color = "#333333";
        format = "<b>▶ %s</b>\n%b";
      };

      # System notifications
      system = {
        appname = "notify-send";
        background = "#262626";
        foreground = "#ffffff";
        frame_color = "#404040";
        format = "<b>▶ SYSTEM</b>\n%b";
      };

      # Volume/brightness notifications
      volume = {
        summary = "*Volume*";
        background = "#1a1a1a";
        foreground = "#aaaaaa";
        frame_color = "#2a2a2a";
        format = "%b";
        timeout = 3;
      };

      brightness = {
        summary = "*Brightness*";
        background = "#1a1a1a";
        foreground = "#aaaaaa";
        frame_color = "#2a2a2a";
        format = "%b";
        timeout = 3;
      };
    };
  };
}
