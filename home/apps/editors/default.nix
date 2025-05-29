{ pkgs, ... }:

{
  imports = [
    ./emacs.nix
    ./helix.nix
    ./kakoune.nix
    ./nvim.nix
  ];
}
