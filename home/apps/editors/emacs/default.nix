{ pkgs, ... }:
{
  services.emacs = with pkgs; {
    enable = true;
    package = emacs;
  };
}
