{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Swift ---
    sourcekit-lsp
  ];
}
