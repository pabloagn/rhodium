{...}: {
  programs.television = {
    enable = true;

    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;

    # Settings
    settings = {
      tick_rate = 30;
      use_nerd_font_icons = true;
      default_channel = "files";

      ui = {
        use_nerd_font_icons = true;
        ui_scale = 100;
        layout = "landscape";
        input_bar_position = "top";

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
        quit = ["esc" "ctrl-c"];
        select_next_entry = ["down" "ctrl-j"];
        select_prev_entry = ["up" "ctrl-k"];
        toggle_preview_panel = ["ctrl-p"];
        toggle_remote_control = ["ctrl-r"];
        toggle_help_panel = ["?"];
        confirm_selection = ["enter" "ctrl-y"];
        clear_input = ["ctrl-u"];
        delete_word_backwards = ["ctrl-w"];
        move_cursor_to_start = ["ctrl-a" "home"];
        move_cursor_to_end = ["ctrl-e" "end"];
      };
    };

    # Television theme
    xdg.configFile."television/themes/kanso.toml".source = ./television/themes/kanso.toml;

    # Television main config
    xdg.configFile."television/config.toml".text = ''
      theme = "kanso"
    '';

    # Television channels (cable)
    xdg.configFile."television/cable/files.toml".source = ./television/cable/files.toml;
    xdg.configFile."television/cable/projects.toml".source = ./television/cable/projects.toml;
    xdg.configFile."television/cable/git.toml".source = ./television/cable/git.toml;
    xdg.configFile."television/cable/recent.toml".source = ./television/cable/recent.toml;
    xdg.configFile."television/cable/config.toml".source = ./television/cable/config.toml;
    xdg.configFile."television/cable/processes.toml".source = ./television/cable/processes.toml;
    xdg.configFile."television/cable/docker.toml".source = ./television/cable/docker.toml;
    xdg.configFile."television/cable/nix.toml".source = ./television/cable/nix.toml;
    xdg.configFile."television/cable/logs.toml".source = ./television/cable/logs.toml;
  };
}
