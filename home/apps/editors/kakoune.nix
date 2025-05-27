{ pkgs, ... }:

{
  programs.kakoune = {
    enable = true;
    package = pkgs.kakoune-unwrapped;
  };
}
