{ pkgs, ... }:

{
  imports = [
    ./fuzzel
  ];

  programs.fuzzel = {
    enable = true;
    package = pkgs.fuzzel;
  };

  home.packages = with pkgs; [
    raffi # Raffi config is generated dynamically. Check home modules...
  ];
}
