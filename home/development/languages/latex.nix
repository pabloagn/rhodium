{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Latex ---
    texlab
    texlivePackages.latexindent
    texlive.combined.scheme-full # Complete texlive distribution
  ];
}
