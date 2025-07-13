{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Elm ---
    elmPackages.elm-format
    elmPackages.elm-language-server
  ];
}
