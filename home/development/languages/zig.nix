{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Zig ---
    zig # Language
    zls # Zig Language Server
  ];
}
