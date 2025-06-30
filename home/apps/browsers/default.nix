{pkgs, ...}: {
  imports = [
    ./firefox.nix
    ./librewolf.nix
    ./qutebrowser.nix
    ./zen.nix
  ];

  home.packages = with pkgs; [
    brave
    tor
    w3m
  ];
}
