{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Kotlin ---
    kotlin-language-server
  ];
}
