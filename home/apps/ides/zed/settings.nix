{ ... }:

{
  programs.zed-editor = {
    userSettings = {

      # Appearance
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_size = 15;
      buffer_font_weight = 300;
      buffer_line_height = "comfortable";
      current_line_highlight = "all";
      selection_highlight = true;
      ui_font_family = "Work Sans";
      ui_font_size = 15;
      ui_font_weight = 400;

      # Behavior
      auto_indent_on_paste = true;
      auto_signature_help = true;
      cursor_blink = false;
      hide_mouse = "on_typing_and_movement";
      hover_popover_delay = 350;
      hover_popover_enabled = true;
      middle_click_paste = true;
      show_completion_documentation = true;
      show_completions_on_input = true;
      show_edit_predictions = true;
      show_wrap_guides = true;
      use_autoclose = true;
      use_auto_surround = true;
      vim_mode = true;
      wrap_guides = [ ];

      # Features and Telemetry
      features = {
        copilot = false;
      };

      telemetry = {
        metrics = false;
      };

      # Gutter
      gutter = {
        breakpoints = true;
        code_actions = true;
        folds = true;
        line_numbers = true;
        runnables = true;
      };

      # Indent Guides
      indent_guides = {
        active_line_width = 1;
        background_coloring = "disabled";
        coloring = "fixed";
        enabled = true;
        line_width = 1;
      };

      # Scrollbar
      scrollbar = {
        axes = {
          horizontal = true;
          vertical = true;
        };
        cursors = true;
        diagnostics = "all";
        git_diff = true;
        search_results = true;
        selected_symbol = true;
        selected_text = true;
        show = "auto";
      };

      # Title Bar
      title_bar = {
        show_branch_icon = false;
        show_onboarding_banner = true;
        show_user_picture = true;
      };

      # Toolbar
      toolbar = {
        agent_review = false;
        breadcrumbs = true;
        quick_actions = true;
        selections_menu = true;
      };
    };
  };
}
