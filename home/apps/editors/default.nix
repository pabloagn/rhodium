{ pkgs, ... }:

{
  imports = [
    ./emacs.nix
    ./helix.nix
    ./nvim
    ./kakoune.nix
  ];
}
