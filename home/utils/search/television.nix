{ ... }:
{
  programs.television = {
    enable = true;

    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;

    # Settings
    settings = {
      tick_rate = 30;

      ui = {
        ui_scale = 100;
        layout = "landscape";
        input_bar_position = "top";
        theme = "kanso";

        preview_panel = {
          size = 50;
          scrollbar = true;
        };

        status_bar = {
          separator_open = "▐";
          separator_close = "▌";
        };

        features = {
          preview_panel = {
            enabled = true;
            visible = true;
          };
          remote_control = {
            enabled = true;
            visible = false;
          };
          help_panel = {
            enabled = true;
            visible = false;
          };
          status_bar = {
            enabled = true;
            visible = true;
          };
        };
      };

      # Binds (format: key = "action")
      keybindings = {
        # Navigation
        down = "select_next_entry";
        ctrl-j = "select_next_entry";
        up = "select_prev_entry";
        ctrl-k = "select_prev_entry";
        # Selection
        enter = "confirm_selection";
        ctrl-y = "copy_entry_to_clipboard";
        # Toggles
        ctrl-p = "toggle_preview";
        ctrl-r = "toggle_remote_control";
        "?" = "toggle_help";
      };
    };
  };

  xdg.configFile = {
    "television/themes/kanso.toml" = {
      source = ./television/themes/kanso.toml;
      force = true;
    };
  };

  xdg.configFile = {
    "television/default_channels.toml" = {
      source = ./television/default_channels.toml;
      force = true;
    };
  };
}
