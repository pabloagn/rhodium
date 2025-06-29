{...}: {
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

      # Binds
      keybindings = {
        select_next_entry = ["down" "ctrl-j"];
        select_prev_entry = ["up" "ctrl-k"];
        toggle_preview = ["ctrl-p"];
        toggle_remote_control = ["ctrl-r"];
        toggle_help = ["?"];
        confirm_selection = ["enter" "ctrl-y"];
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
