{ pkgs, ... }:
{
  imports = [
    ./libreoffice.nix
    ./onlyoffice.nix
    ./slack.nix
    ./teams.nix
    ./zoom.nix
  ];
}
