{ pkgs, ... }:
{
  programs.vscode = {
    profiles = {
      default = {
        keybindings =
          [
            {
              key = "ctrl+1";
              command = "editor.action.commentLine";
              when = "editorTextFocus && !editorReadonly";
            }
            {
              key = "ctrl+n";
              command = "explorer.newFile";
            }
          ];
      };
    };
  };
}
