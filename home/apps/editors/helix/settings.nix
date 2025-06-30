{...}: {
  programs.helix.settings = {
    theme = "chiaroscuro";

    keys.normal = {
      D = ["extend_to_line_bounds" "delete_selection"];
      "space" = {
        space = ["save_selection" "select_all" "yank_main_selection_to_clipboard" "jump_backward"];
      };
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
      smart-tab = {
        enable = true;
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
      };
    };
  };
}
