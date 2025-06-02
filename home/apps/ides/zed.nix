{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor;
    extensions = [
      "nix"
      "html"
      "toml"
      "dockerfile"
      "catpuccin icons"
      "git firefly"
    ];
    userSettings = {
      features = {
        copilot = false;
      };
      telemetry = {
        metrics = false;
      };
      "experimental.theme_overrides" = {
        "editor.background" = "#1e1e2e";
        "background" = "#27273b";
        "surface.background" = "#181825";
        "elevated_surface.background" = "#181825";
        "panel.background" = "#181825";
        "status_bar.background" = "#11111b";
        "title_bar.background" = "#11111b";
        "tab_bar.background" = "#11111b80";
        "tab.active_background" = "#1e1e2e";
        "tab.inactive_background" = "#0b0b11";
        "toolbar.background" = "#1e1e2e";
        syntax = {
          comment = {
            font_style = "italic";
          };
          "comment.doc" = {
            font_style = "italic";
          };
        };
      };
      icon_theme = "Catppuccin Mocha";
      ui_font_size = 15;
      buffer_font_size = 15;
      buffer_font_weight = 300;
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_line_height = "comfortable";
      hover_popover_enabled = true;
      cursor_blink = false;
      hover_popover_delay = 350;
      ui_font_family = "Work Sans";
      ui_font_weight = 400;
      auto_signature_help = true;
      show_wrap_guides = true;
      use_autoclose = true;
      use_auto_surround = true;
      show_edit_predictions = true;
      auto_indent_on_paste = true;
      wrap_guides = [ ];
      show_completion_documentation = true;
      show_completions_on_input = true;
      current_line_highlight = "all";
      selection_highlight = true;
      hide_mouse = "on_typing_and_movement";
      vim_mode = true;
      middle_click_paste = true;
      gutter = {
        line_numbers = true;
        code_actions = true;
        runnables = true;
        breakpoints = true;
        folds = true;
      };
      indent_guides = {
        enabled = true;
        line_width = 1;
        active_line_width = 1;
        coloring = "fixed";
        background_coloring = "disabled";
      };
      scrollbar = {
        show = "auto";
        cursors = true;
        git_diff = true;
        search_results = true;
        selected_text = true;
        selected_symbol = true;
        diagnostics = "all";
        axes = {
          horizontal = true;
          vertical = true;
        };
      };
      title_bar = {
        show_branch_icon = false;
        show_onboarding_banner = true;
        show_user_picture = true;
      };
      toolbar = {
        breadcrumbs = true;
        quick_actions = true;
        selections_menu = true;
        agent_review = false;
      };
      theme = {
        mode = "system";
        light = "One Light";
        dark = "Chiaroscuro";
      };
      languages = {
        Python = {
          tab_size = 4;
          formatter = "language_server";
          format_on_save = "on";
        };
        Nix = {
          language_servers = [ "nil" ];
          formatter = {
            external = {
              command = "nixpkgs-fmt";
              arguments = [ ];
            };
          };
          format_on_save = "on";
        };
      };
      lsp = {
        nil = {
          binary = {
            path = "nil";
            arguments = [ ];
          };
        };
      };
      auto_install_extensions = {
        html = true;
      };
    };
  };

  xdg.configFile."zed/themes/chiaroscuro.json" = {
    source = ./zed/themes/chiaroscuro.json;
  };
}
