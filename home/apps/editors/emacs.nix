{ pkgs, ... }:

{
  imports = [
    ./emacs
  ];

  programs.emacs = {
    enable = false;
    package = pkgs.emacs;
  };
}
