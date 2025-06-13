{ pkgs, ... }:

{
  imports = [
    ./emacs
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    # extraConfig = ''
    #   (setq standard-indent 2)
    # '';
  };
}
