# modules/hardware/default.nix

{ pkgs }:

{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./keyboard.nix
    ./mouse.nix
    ./printers.nix
    ./video.nix
    ./wifi.nix
  ];
}
