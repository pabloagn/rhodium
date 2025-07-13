{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Toml ---
    taplo
  ];
}
