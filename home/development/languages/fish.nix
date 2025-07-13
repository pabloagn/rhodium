{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Fish Shell ---
    fish-lsp
  ];
}
