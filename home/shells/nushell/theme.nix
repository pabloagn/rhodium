{...}: {
  programs.nushell.extraConfig = ''
    # Define custom theme
    def chiaroscuro [] {
      {
        separator: "#a0a0a0"
        leading_trailing_space_bg: { attr: "n" }
        header: { fg: "#87d75f" attr: "b" }
        empty: "#5f87d7"
        bool: {
          true: { fg: "#5fd7d7" }
          false: { fg: "#c0c0c0" }
        }
        int: "#ffffff"
        filesize: {
          metric: { fg: "#87d75f" attr: "b" }
        }
        duration: "#ffffff"
        date: {
          now: { fg: "#5fd7d7" attr: "b" }
        }
        range: "#ffffff"
        float: "#ffffff"
        string: "#87d75f"
        nothing: "#ffffff"
        binary: "#ffffff"
        cell_path: "#ffffff"
        row_index: { fg: "#87d75f" attr: "b" }
        record: "#ffffff"
        list: "#ffffff"
        block: "#ffffff"
        hints: "#808080"
        search_result: { fg: "#000000" bg: "#ffff5f" }

        shape_and: { fg: "#d75fd7" attr: "b" }
        shape_binary: { fg: "#d75fd7" attr: "b" }
        shape_block: { fg: "#5f87d7" attr: "b" }
        shape_bool: "#5fd7d7"
        shape_closure: { fg: "#87d75f" attr: "b" }
        shape_custom: "#87d75f"
        shape_datetime: { fg: "#5fd7d7" attr: "b" }
        shape_directory: "#5fd7d7"
        shape_external: "#5fd7d7"
        shape_externalarg: { fg: "#87d75f" attr: "b" }
        shape_external_resolved: { fg: "#ffd75f" attr: "b" }
        shape_filepath: "#5fd7d7"
        shape_flag: { fg: "#5f87d7" attr: "b" }
        shape_float: { fg: "#d75fd7" attr: "b" }
        shape_garbage: { fg: "#ffffff" bg: "#ff0000" attr: "b" }
        shape_glob_interpolation: { fg: "#5fd7d7" attr: "b" }
        shape_globpattern: { fg: "#5fd7d7" attr: "b" }
        shape_int: { fg: "#d75fd7" attr: "b" }
        shape_internalcall: { fg: "#5fd7d7" attr: "b" }
        shape_keyword: { fg: "#5fd7d7" attr: "b" }
        shape_list: { fg: "#5fd7d7" attr: "b" }
        shape_literal: "#5f87d7"
        shape_match_pattern: "#87d75f"
        shape_matching_brackets: { attr: "u" }
        shape_nothing: "#5fd7d7"
        shape_operator: "#ffd75f"
        shape_or: { fg: "#d75fd7" attr: "b" }
        shape_pipe: { fg: "#d75fd7" attr: "b" }
        shape_range: { fg: "#ffd75f" attr: "b" }
        shape_record: { fg: "#5fd7d7" attr: "b" }
        shape_redirection: { fg: "#d75fd7" attr: "b" }
        shape_signature: { fg: "#87d75f" attr: "b" }
        shape_string: "#87d75f"
        shape_string_interpolation: { fg: "#5fd7d7" attr: "b" }
        shape_table: { fg: "#5f87d7" attr: "b" }
        shape_variable: "#d75fd7"
        shape_vardecl: "#d75fd7"
        shape_raw_string: { fg: "#d787d7" attr: "b" }
      }
    }

    # Apply the theme
    $env.config = ($env.config | merge {
      color_config: (chiaroscuro)
    })

    # Configure LS_COLORS for better file type visibility
    $env.LS_COLORS = (vivid generate mocha)
  '';
}
