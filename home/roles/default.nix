# home/roles/default.nix

{ lib, ... }:

{
  imports = [
    ./admin.nix
    ./developer.nix
    ./desktop.nix
  ];
}
