{pkgs, ...}: {
  programs.vscode = {
    profiles = {
      default = {
        extensions = with pkgs; [
          vscode-extensions.editorconfig.editorconfig
          vscode-extensions.streetsidesoftware.code-spell-checker
          vscode-extensions.ziglang.vscode-zig
          vscode-extensions.ms-vscode-remote.remote-wsl
          vscode-extensions.aaron-bond.better-comments
        ];
      };
    };
  };
}
