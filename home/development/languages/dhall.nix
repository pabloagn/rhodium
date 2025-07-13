{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Dhall ---
    dhall # Binary
    dhall-lsp-server # Server
  ];
}
