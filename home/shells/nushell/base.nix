{ config, lib, ... }:

{
  programs.nushell = {
    # Set the default editor
    settings = {
      # General settings
      show_banner = false;
      
      # Table settings
      table = {
        mode = "rounded";
        index_mode = "always";
        show_empty = true;
        trim = {
          methodology = "wrapping";
          wrapping_try_keep_words = true;
        };
      };
      
      # Editor settings
      buffer_editor = "nvim";
      
      # Shell integration
      shell_integration = {
        osc2 = true;
        osc7 = true;
        osc8 = true;
        osc9_9 = false;
        osc133 = true;
        osc633 = true;
        reset_application_mode = true;
      };
      
      # History settings
      history = {
        max_size = 100000;
        sync_on_enter = true;
        file_format = "sqlite";
        isolation = false;
      };
      
      # Completions
      completions = {
        case_sensitive = false;
        quick = true;
        partial = true;
        algorithm = "fuzzy";
        external = {
          enable = true;
          max_results = 100;
          completer = null;
        };
        use_ls_colors = true;
      };
      
      # File operations
      filesize = {
        metric = false;
        format = "auto";
      };
      
      # LS colors
      use_ls_colors = true;
      
      # Cursor shape
      cursor_shape = {
        emacs = "line";
        vi_insert = "line";
        vi_normal = "block";
      };
      
      # Color config
      color_config = {
        separator = "white";
        leading_trailing_space_bg = { attr = "n"; };
        header = "green_bold";
        empty = "blue";
        bool = {
          true = "light_cyan";
          false = "light_gray";
        };
        int = "white";
        duration = "white";
        date = "purple";
        range = "white";
        float = "white";
        string = "green";
        nothing = "white";
        binary = "white";
        cell_path = "white";
        row_index = "green_bold";
        record = "white";
        list = "white";
        block = "white";
        hints = "dark_gray";
        search_result = { bg = "red"; fg = "white"; };
        shape_and = "purple_bold";
        shape_binary = "purple_bold";
        shape_block = "blue_bold";
        shape_bool = "light_cyan";
        shape_closure = "green_bold";
        shape_custom = "green";
        shape_datetime = "cyan_bold";
        shape_directory = "cyan";
        shape_external = "cyan";
        shape_externalarg = "green_bold";
        shape_external_resolved = "light_yellow_bold";
        shape_filepath = "cyan";
        shape_flag = "blue_bold";
        shape_float = "purple_bold";
        shape_garbage = { fg = "white"; bg = "red"; attr = "b"; };
        shape_glob_interpolation = "cyan_bold";
        shape_globpattern = "cyan_bold";
        shape_int = "purple_bold";
        shape_internalcall = "cyan_bold";
        shape_keyword = "cyan_bold";
        shape_list = "cyan_bold";
        shape_literal = "blue";
        shape_match_pattern = "green";
        shape_matching_brackets = { attr = "u"; };
        shape_nothing = "light_cyan";
        shape_operator = "yellow";
        shape_or = "purple_bold";
        shape_pipe = "purple_bold";
        shape_range = "yellow_bold";
        shape_record = "cyan_bold";
        shape_redirection = "purple_bold";
        shape_signature = "green_bold";
        shape_string = "green";
        shape_string_interpolation = "cyan_bold";
        shape_table = "blue_bold";
        shape_variable = "purple";
        shape_vardecl = "purple";
        shape_raw_string = "light_purple";
      };
      
      # Keybindings
      keybindings = [
        {
          name = "completion_menu";
          modifier = "none";
          keycode = "tab";
          mode = ["emacs" "vi_normal" "vi_insert"];
          event = {
            until = [
              { send = "menu"; name = "completion_menu"; }
              { send = "menunext"; }
              { edit = "complete"; }
            ];
          };
        }
        {
          name = "history_menu";
          modifier = "control";
          keycode = "char_r";
          mode = ["emacs" "vi_normal" "vi_insert"];
          event = { send = "menu"; name = "history_menu"; };
        }
        {
          name = "help_menu";
          modifier = "control";
          keycode = "char_h";
          mode = ["emacs" "vi_normal" "vi_insert"];
          event = { send = "menu"; name = "help_menu"; };
        }
      ];
      
      # Menus
      menus = [
        {
          name = "completion_menu";
          only_buffer_difference = false;
          marker = "| ";
          type = {
            layout = "columnar";
            columns = 4;
            col_width = 20;
            col_padding = 2;
          };
          style = {
            text = "green";
            selected_text = "green_reverse";
            description_text = "yellow";
          };
        }
        {
          name = "history_menu";
          only_buffer_difference = true;
          marker = "? ";
          type = {
            layout = "list";
            page_size = 10;
          };
          style = {
            text = "green";
            selected_text = "green_reverse";
            description_text = "yellow";
          };
        }
        {
          name = "help_menu";
          only_buffer_difference = true;
          marker = "? ";
          type = {
            layout = "description";
            columns = 4;
            col_width = 20;
            col_padding = 2;
            selection_rows = 4;
            description_rows = 10;
          };
          style = {
            text = "green";
            selected_text = "green_reverse";
            description_text = "yellow";
          };
        }
      ];
    };
    
    # Load plugins
    extraConfig = ''
      # Source zoxide
      source ${config.programs.zoxide.package}/share/zoxide/init.nu
      
      # Load atuin if enabled  
      ${lib.optionalString config.programs.atuin.enable ''
        source ${config.programs.atuin.package}/share/atuin/init.nu
      ''}
      
      # Load starship if enabled
      ${lib.optionalString config.programs.starship.enable ''
        use ${config.programs.starship.package}/share/starship/init.nu
      ''}
    '';
  };
}
