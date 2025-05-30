{ pkgs, ... }:

{
  imports = [
    ./cursor.nix
    ./rstudio.nix
    ./texmaker.nix
    ./vscode.nix
    ./zed.nix
  ];
}
