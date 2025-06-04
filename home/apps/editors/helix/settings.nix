{ ... }:
{
  programs.helix.settings = {
    theme = "chiaroscuro";

    keys.normal = {
      D = [ "extend_to_line_bounds" "delete_selection" ];
      "space" = {
        space = [ "save_selection" "select_all" "yank_main_selection_to_clipboard" "jump_backward" ];
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
      evil = true; # Disable evil to remove vim bindings altogether
      path-completion = true;
      # ruler-char = "⎸";
      # rulers = [10 20 30]; # Rulers are rendered with ${ruler-char}      line-number = "relative";
      mouse = true;
      default-yank-register = "+";
      middle-click-paste = true;
      scroll-lines = 1;
      scrolloff = 8;
      cursorline = true;
      cursorcolumn = false;
      auto-completion = true;
      auto-format = true;
      auto-info = true;
      idle-timeout = 250;
      completion-trigger-len = 1;
      true-color = true;
      undercurl = true;
      bufferline = "always";
      insert-final-newline = true;
      popup-border = "all";
      indent-heuristic = "hybrid";
      clipboard-provider = "wayland";
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
        #display-color-swatches = true;
      };
    };
  };
}
