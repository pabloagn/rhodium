{ pkgs, ... }:

{
  programs.vscode = {
    profiles = {
      default = {
        extensions = [
          pkgs.vscode-extensions.editorconfig.editorconfig
          pkgs.vscode-extensions.streetsidesoftware.code-spell-checker
        ];
      };
    };
  };
}
