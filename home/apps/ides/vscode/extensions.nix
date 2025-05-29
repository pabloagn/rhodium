{ pkgs }:

{
  programs.vscode = {
    profiles = {
      default = {
        extensions = with pkgs; [
          vscode-extensions.editorconfig.editorconfig
          streetsidesoftware.code-spell-checker
        ];
      };
    };
  };
}
