{ pkgs, ... }:
{
  imports = [
    # ./cursor.nix
    # ./lapce.nix
    ./rstudio.nix
    ./texmaker.nix
    ./vscode.nix
    ./zed.nix
  ];
}
