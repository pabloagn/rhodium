{ ... }:

{
  programs.zed-editor = {
    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          "ctrl-b" = "workspace::ToggleLeftDock";
        };
      }
      {
        context = "Editor";
        bindings = {
          "space-c" = "editor::ToggleComments";
          "ctrl-b" = "workspace::ToggleLeftDock";
        };
      }
    ];
  };
}
