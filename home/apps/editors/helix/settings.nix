{ ... }:
{
  programs.helix.settings = {
    theme = "chiaroscuro";

    keys.normal = {
      D = [
        "extend_to_line_bounds"
        "delete_selection"
      ];
      "space" = {
        space = [
          "save_selection"
          "select_all"
          "yank_main_selection_to_clipboard"
          "jump_backward"
        ];
        "/" = "global_search";
      };
      "C-d" = [
        "half_page_down"
        "align_view_center"
      ];
      "C-u" = [
        "half_page_up"
        "align_view_center"
      ];
      "C-s" = ":write";
    };

    keys.insert = {
      "C-s" = [
        "normal_mode"
        ":write"
      ];
    };

    # keys.select = {
    #   "d" = [ "delete_selection" "normal_mode" ];
    #   "i" = {
    #     w = "select_textobject_inner";
    #   };
    #   "a" = {
    #     w = "select_textobject_around";
    #   };
    #   G = "goto_file_end";
    #   g = {
    #     g = "goto_file_start";
    #   };
    # };

    editor = {
      auto-completion = true;
      auto-format = true;
      auto-info = true;
      bufferline = "always";
      clipboard-provider = "wayland";
      completion-trigger-len = 1;
      cursorcolumn = false;
      cursorline = true;
      default-yank-register = "+";
      evil = true; # NOTE: Disable evil to remove vim bindings altogether
      idle-timeout = 250;
      indent-heuristic = "hybrid";
      insert-final-newline = true;
      middle-click-paste = true;
      mouse = true;
      path-completion = true;
      popup-border = "all";
      scroll-lines = 1;
      scrolloff = 8;
      true-color = true;
      undercurl = true;
      color-modes = true;
      end-of-line-diagnostics = "hint";
      line-number = "relative";
      trim-trailing-whitespace = true;
      smart-tab = {
        enable = true;
      };
      auto-save = {
        focus-lost = true;
        after-delay.enable = true;
        after-delay.timeout = 5000;
      };
      inline-diagnostics = {
        cursor-line = "warning";
      };
      soft-wrap = {
        enable = true;
        wrap-at-text-width = true;
      };
      search = {
        smart-case = true;
        wrap-around = true;
      };
      whitespace.render = {
        tab = "all";
        nbsp = "all";
      };
      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      file-picker = {
        hidden = true;
        git-ignore = true;
      };
      indent-guides = {
        render = true;
        character = "│";
      };
      statusline = {
        separator = " │ ";
        mode.normal = "NORMAL";
        mode.insert = "INSERT";
        mode.select = "SELECT";
        left = [
          "mode"
          "spinner"
          "file-absolute-path"
          "read-only-indicator"
          "file-modification-indicator"
        ];
        center = [
          "version-control"
        ];
        right = [
          "diagnostics"
          "workspace-diagnostics"
          "spacer"
          "selections"
          "spacer"
          "position"
          "position-percentage"
          "total-line-numbers"
          "spacer"
          "file-encoding"
          "file-line-ending"
          "file-type"
        ];
      };
      gutters = [
        "diagnostics"
        "spacer"
        "line-numbers"
        "spacer"
        "diff"
      ];

      lsp = {
        enable = true;
        auto-signature-help = true;
        display-inlay-hints = true;
        display-messages = true;
        display-progress-messages = true;
        display-signature-help-docs = true;
        display-color-swatches = true;
        snippets = true;
      };
    };
  };
}
