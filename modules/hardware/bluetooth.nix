{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    blueman # GUI bluetooth manager
    bluez # Official linux protocol bluetooth stack
    bluez-tools # Set of tools to manage bluetooth devices for linux
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    # Bluetooth settings for better device support (AirPods, etc.)
    # Reference: https://wiki.nixos.org/wiki/Bluetooth
    settings = {
      General = {
        Experimental = true; # Required for battery reporting and some codecs
        FastConnectable = true; # Faster reconnection (slightly higher power usage)
      };
      Policy = {
        AutoEnable = true; # Auto-enable controller on boot
      };
    };
  };

  services = {
    blueman.enable = true;
  };
}
