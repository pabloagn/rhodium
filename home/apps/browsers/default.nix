{ pkgs, ... }:

{
  imports = [
    ./firefox.nix
    ./firefox.nix
    ./qutebrowser.nix
    ./librewolf.nix
    ./zen.nix
  ];

  home.packages = with pkgs; [
    # brave
    w3m
    tor
  ];
}
