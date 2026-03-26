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

    # Bluetooth settings for better device support and fast reconnection
    # Reference: https://wiki.nixos.org/wiki/Bluetooth
    # Reference: https://github.com/bluez/bluez/blob/master/src/main.conf
    settings = {
      General = {
        Experimental = true; # Required for battery reporting and some codecs
        FastConnectable = true; # Faster page scan for reconnection (slightly higher power usage)
        JustWorksRepairing = "always"; # Auto-repair JustWorks pairings without re-pair prompts
        DiscoverableTimeout = 0; # Stay discoverable indefinitely when discovery is on (better new device pairing)
      };
      Policy = {
        AutoEnable = true; # Auto-enable controller on boot
        ReconnectAttempts = 7; # Number of reconnection attempts after link loss
        ReconnectIntervals = "1,2,4,8,16,32,64"; # Seconds between reconnect attempts (exponential backoff)
      };
      LE = {
        # Tuned LE connection parameters for faster reconnection of BLE HID devices (e.g. MX Master)
        MinConnectionInterval = 6; # ~7.5ms (6 * 1.25ms) — faster connection setup
        MaxConnectionInterval = 9; # ~11.25ms — low latency for HID devices
        ConnectionLatency = 44; # Peripheral can skip up to 44 intervals when idle (saves power)
        ConnectionSupervisionTimeout = 216; # ~2.16s timeout before link considered lost
        Autoconnecttimeout = 60; # 60s timeout for auto-connection attempts
      };
    };
  };

  # Disable btusb USB autosuspend at the kernel module level
  # The btusb module re-enables autosuspend when it binds (calls usb_enable_autosuspend()),
  # which overrides any udev rules. This is the root cause of ~20s reconnection delays
  # for Bluetooth devices like the MX Master after idle or power cycle.
  boot.extraModprobeConfig = ''
    options btusb enable_autosuspend=n
  '';

  services = {
    blueman.enable = true;
  };
}
