{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Cmake ---
    cmake-language-server
    cmake-format
  ];
}
