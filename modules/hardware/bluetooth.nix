

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    blueman
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
