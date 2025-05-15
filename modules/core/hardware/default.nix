# modules/core/hardware/default.nix

{ lib, pkgs, config, modulesPath, ... }:

{
  imports = [
    # Core Imports (Come mainly from hardware-configuration.nix)
    (modulesPath + "/hardware/network/broadcom-43xx.nix")
    (modulesPath + "/installer/scan/not-detected.nix")
    ./boot.nix
    ./filesystem.nix
    ./networking.nix
    ./cpu.nix
    ./system.nix

    # Services
    ./services.nix

    # Hardware Imports
    ./audio.nix
    ./bluetooth.nix
    ./keyboard.nix
    ./mouse.nix
    ./printers.nix
    ./video.nix
    ./wifi.nix
  ];
}
