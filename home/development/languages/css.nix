{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Css/html/json ---
    vscode-langservers-extracted # NOTE: Includes html, css, json, eslint
    html-tidy
    dart-sass # Sass compiler
  ];
}
