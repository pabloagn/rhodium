{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Go ---
    go # Go programming language compiler and toolchain
    goimports-reviser
    gopls
    gofumpt
    gomodifytags
    gotests
    gore
  ];
}
