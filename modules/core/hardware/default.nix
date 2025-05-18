# modules/core/hardware/default.nix

{ lib, pkgs, config, modulesPath, ... }:

{
  imports = [
    ./cpu.nix
    ./audio.nix
    ./bluetooth.nix
    ./keyboard.nix
    ./mouse.nix
    ./printers.nix
    ./video.nix
    ./services.nix
  ];
}
