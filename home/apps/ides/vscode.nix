{pkgs, ...}: {
  imports = [
    ./vscode
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    mutableExtensionsDir = true; # Can VS Code modify extensions directory? Of course not
    profiles = {
      default = {
        enableUpdateCheck = false; # Silence the mf
      };
    };
  };
}
