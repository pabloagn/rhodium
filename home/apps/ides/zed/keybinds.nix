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
        context = "Editor && vim_mode == normal";
        bindings = {
          "space c" = "editor::ToggleComments";
        };
      }
    ];
  };
}
