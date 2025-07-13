{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Clojure ---
    clojure-lsp # Server
    cljfmt # Formatter
    clj-kondo # Linter
  ];
}
