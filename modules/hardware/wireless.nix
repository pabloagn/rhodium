{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    networkmanagerapplet # GUI for setting up WiFi & Bluetooth
    blueman
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
