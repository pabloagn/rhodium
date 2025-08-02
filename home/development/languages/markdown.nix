{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Markdown ---
    markdownlint-cli2 # Formatter
    markdown-oxide
    marksman
  ];
}
