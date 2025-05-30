# modules/hardware/default.nix

{ pkgs, inputs, rhodiumLib, users, host, ... }:

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
