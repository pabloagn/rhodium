{ pkgs, ... }:

{
  programs.fuzzel = {
    enable = true;
    package = pkgs.fuzzel;
  };

  xdg.configFile."fuzzel/fuzzel.ini" = { source = ./fuzzel.ini; };
}
