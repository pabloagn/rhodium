{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Networking
    networkmanager # Network configuration & management CLI tool
    networkmanagerapplet # GUI for setting up WiFi & Bluetooth
    # Bluetooth
    blueman # GUI bluetooth manager
    bluez # Official linux protocol bluetooth stack
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
