{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Jinja2 ---
    jinja-lsp # Language server
    jinja2-cli # CLI
  ];
}
