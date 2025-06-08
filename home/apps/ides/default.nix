{ pkgs, ... }:

{
  imports = [
    # ./cursor.nix
    ./rstudio.nix
    ./texmaker.nix
    ./vscode.nix
    ./zed.nix
  ];

  home.packages = with pkgs; [
    lapce # Lightning-fast and Powerful Code Editor written in Rust
  ];
}
