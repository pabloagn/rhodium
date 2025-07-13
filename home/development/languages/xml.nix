{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Xml ---
    lemminx
  ];
}
