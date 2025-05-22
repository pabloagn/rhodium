# home/development/editors/helix/keys.nix

let
  # Base key mappings
  baseNormalKeys = {
    # Basic movement
    a = ["ensure_selections_forward" "append_mode"];
    G = "goto_file_end";
    g.g = "goto_file_start";
    x = "extend_line";
    X = "extend_to_line_bounds";
    "0" = "goto_line_start";
    "$" = "goto_line_end";

    # Deletion and yanking
    D = ["extend_to_line_bounds" "delete_selection"];
    Y = [
      "goto_line_start"
      "extend_to_line_end"
      "yank_main_selection_to_clipboard"
      "collapse_selection"
    ];

    # Enhanced movement
    right = [
      "ensure_selections_forward"
      "extend_char_right"
      "ensure_selections_forward"
      "collapse_selection"
    ];

    # Paste operations
    p = "paste_clipboard_before";
    P = ["open_below" "normal_mode" "paste_clipboard_before"];
  };

  baseSelectKeys = {
    y = ["yank_main_selection_to_clipboard" "normal_mode"];
    d = ["delete_selection" "normal_mode"];
    i.w = "select_textobject_inner";
    a.w = "select_textobject_around";
    G = "goto_file_end";
    g.g = "goto_file_start";
  };

  # Space-based leader key mappings
  spaceKeymaps = {
    # Buffer operations
    buffer = {
      space = [
        "save_selection"
        "select_all"
        "yank_main_selection_to_clipboard"
        "jump_backward"
      ];
      "w" = ":write";
      "q" = ":quit";
      "Q" = ":quit!";
      "n" = ":new";
    };

    # File operations
    file = {
      "f" = "file_picker";
      "F" = "file_picker_in_current_directory";
      "r" = "recent_files";
      "s" = ":write";
      "S" = ":write-all";
    };

    # Search and navigation
    search = {
      "/" = "search";
      "?" = "rsearch";
      "n" = "search_next";
      "N" = "search_prev";
      "*" = "search_selection";
      "g" = "global_search";
    };

    # LSP operations
    lsp = {
      "d" = "goto_definition";
      "D" = "goto_declaration";
      "t" = "goto_type_definition";
      "r" = "goto_reference";
      "i" = "goto_implementation";
      "h" = "hover";
      "a" = "code_action";
      "R" = "rename_symbol";
      "f" = "format_selections";
    };

    # Window/view operations
    view = {
      "v" = "vsplit";
      "h" = "hsplit";
      "c" = "wclose";
      "o" = "wonly";
      "j" = "jump_view_down";
      "k" = "jump_view_up";
      "l" = "jump_view_right";
      # "h" = "jump_view_left";
    };
  };

  # Insert mode mappings
  insertKeys = {
    "C-c" = "normal_mode";
    "C-w" = "delete_word_backward";
    "C-u" = "delete_to_line_start";
    "C-k" = "delete_to_line_end";
  };

  # Key mapping profiles
  profiles = {
    # Vim-like mappings (default)
    vim = {
      normal = baseNormalKeys // {
        space = spaceKeymaps.buffer;
        "," = {
          "f" = spaceKeymaps.file;
          "s" = spaceKeymaps.search;
          "l" = spaceKeymaps.lsp;
          "v" = spaceKeymaps.view;
        };
      };
      select = baseSelectKeys;
      insert = insertKeys;
    };

    # VSCode-like mappings
    vscode = {
      normal = baseNormalKeys // {
        space = spaceKeymaps.buffer;
        "C-p" = "file_picker";
        "C-S-p" = "command_palette";
        "C-f" = "search";
        "C-h" = "search_next";
        "F12" = "goto_definition";
        "S-F12" = "goto_reference";
        "C-." = "code_action";
        "F2" = "rename_symbol";
      };
      select = baseSelectKeys;
      insert = insertKeys // {
        "C-p" = "completion";
        "C-space" = "completion";
      };
    };

    # Emacs-like mappings
    emacs = {
      normal = baseNormalKeys // {
        "C-x" = {
          "C-f" = "file_picker";
          "C-s" = ":write";
          "C-c" = ":quit";
          "b" = "buffer_picker";
          "k" = "wclose";
        };
        "M-x" = "command_palette";
        "C-s" = "search";
        "C-r" = "rsearch";
      };
      select = baseSelectKeys;
      insert = insertKeys // {
        "C-a" = "goto_line_start";
        "C-e" = "goto_line_end";
        "C-f" = "move_char_right";
        "C-b" = "move_char_left";
        "C-n" = "move_line_down";
        "C-p" = "move_line_up";
      };
    };

    # Minimal mappings for quick editing
    minimal = {
      normal = {
        space.space = [
          "save_selection"
          "select_all"
          "yank_main_selection_to_clipboard"
          "jump_backward"
        ];
        G = "goto_file_end";
        g.g = "goto_file_start";
        p = "paste_clipboard_before";
        Y = [
          "goto_line_start"
          "extend_to_line_end"
          "yank_main_selection_to_clipboard"
          "collapse_selection"
        ];
      };
      select = {
        y = ["yank_main_selection_to_clipboard" "normal_mode"];
        d = ["delete_selection" "normal_mode"];
      };
      insert = {
        "C-c" = "normal_mode";
      };
    };
  };

in
{
  # Export key mapping profiles
  inherit profiles;

  # Export individual keymap sets for customization
  inherit spaceKeymaps baseNormalKeys baseSelectKeys insertKeys;

  # Default profile
  default = profiles.vim;

  # Helper function to merge custom keys with a profile
  mkCustomKeys = profile: customKeys:
    let
      baseKeys = profiles.${profile};
    in
    {
      normal = baseKeys.normal // (customKeys.normal or {});
      select = baseKeys.select // (customKeys.select or {});
      insert = baseKeys.insert // (customKeys.insert or {});
    };
}
