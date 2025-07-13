{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Markdown ---
    markdown-oxide
    marksman
  ];
}
