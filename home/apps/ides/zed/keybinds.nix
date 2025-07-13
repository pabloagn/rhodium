{ ... }:
{
  programs.zed-editor = {
    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          "ctrl-b" = "workspace::ToggleLeftDock";
          "alt-tab" = "project_panel::ToggleFocus";
        };
      }
      {
        context = "Editor";
        bindings = {
          "ctrl-b" = "workspace::ToggleLeftDock";
        };
      }
      {
        context = "Editor && vim_mode == normal || vim_mode == visual";
        bindings = {
          "space c" = "editor::ToggleComments";
        };
      }

      # --- Repl ---
      {
        context = "Editor && language == python";
        bindings = {
          "ctrl-shift-enter" = "repl::Run"; # Run current cell/selection
          "shift-enter" = "repl::Run"; # Alternative binding like Jupyter
          "ctrl-shift-c" = "repl::ClearOutputs"; # Clear outputs
          "alt-enter" = [
            "repl::Run"
            "editor::MoveDown"
          ]; # Run and move to next line
        };
      }
    ];
  };
}
