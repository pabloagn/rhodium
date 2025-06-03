{ ... }:
{
  programs.helix.settings = {
    theme = "chiaroscuro";

    keys.normal = {
      a = [ "ensure_selections_forward" "append_mode" ];
      G = "goto_file_end";
      g = {
        g = "goto_file_start";
      };
      x = "extend_line";
      X = "extend_to_line_bounds";
      "0" = "goto_line_start";
      "$" = "goto_line_end";
      D = [ "extend_to_line_bounds" "delete_selection" ];
      Y = [ "goto_line_start" "extend_to_line_end" "yank_main_selection_to_clipboard" "collapse_selection" ];
      right = [ "ensure_selections_forward" "extend_char_right" "ensure_selections_forward" "collapse_selection" ];
      p = "paste_clipboard_before";
      P = [ "open_below" "normal_mode" "paste_clipboard_before" ];
      "space" = {
        space = [ "save_selection" "select_all" "yank_main_selection_to_clipboard" "jump_backward" ];
      };
    };

    keys.select = {
      "y" = [ "yank_main_selection_to_clipboard" "normal_mode" ];
      "d" = [ "delete_selection" "normal_mode" ];
      "i" = {
        w = "select_textobject_inner";
      };
      "a" = {
        w = "select_textobject_around";
      };
      G = "goto_file_end";
      g = {
        g = "goto_file_start";
      };
    };

    editor = {
      line-number = "relative";
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

      lsp = {
        enable = true;
        auto-signature-help = true;
        display-inlay-hints = true;
        #display-color-swatches = true;
      };
    };
  };
}
