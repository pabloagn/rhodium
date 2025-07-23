{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Go ---
    go
    goimports-reviser
    gopls
    gofumpt
    gomodifytags
    gotests
    gore
    prettier-plugin-go-template
  ];
}
