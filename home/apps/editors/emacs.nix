{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-nox;
    # package = pkgs.emacs;
  };
}
