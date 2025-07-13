{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Dhall ---
    dhall-lsp-server
  ];
}
