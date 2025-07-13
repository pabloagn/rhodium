{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- R ---
    rPackages.styler
    rPackages.languageserver
  ];
}
