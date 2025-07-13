{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Typst ---
    typst # New markup-based typesetting tool
    tinymist # Integrated language server for typst (includes formatters)
  ];
}
