{pkgs, ...}: {
  imports = [
    ./vscode
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    # package = pkgs.vscodium;
    mutableExtensionsDir = true; # Can VS Code modify extensions directory?
    profiles = {
      default = {
        enableUpdateCheck = false; # Silence the mf
      };
    };
  };
}
