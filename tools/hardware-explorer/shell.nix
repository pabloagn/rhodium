# tools/hardware-explorer/shell.nix
# TODO: Complete this file

{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "rhodium-info-gather-shell";
  nativeBuildInputs = with pkgs; [
    # System Information
    pciutils # for lspci
    usbutils # for lsusb
    dmidecode # for dmidecode (needs sudo)

    # Network
    iw # for WiFi details
    iproute2 # for ip command

    # Audio
    alsa-utils # for aplay, amixer

    # Storage
    smartmontools # for smartctl (needs sudo)
    util-linux # for lsblk

    # Display
    xorg.xrandr # for X11 display info
    hyprctl # for hyprland display info
    read-edid # for get-edid, parse-edid (needs sudo)

    # Power / Battery
    upower

    # Input
    libinput # provides libinput list-devices (needs sudo)

    # Vulkan/OpenGL
    vulkan-tools
  ];

  shellHook = ''
    echo ""
    echo "Rhodium Hardware Information Gathering Shell"
    echo "---------------------------------------------"
    echo "Many commands below require 'sudo' for full output (e.g., dmidecode, smartctl, get-edid, libinput)."
    echo ""
    echo "Useful commands to gather information:"
    echo "  Network:"
    echo "    lspci -nnk | grep -iEA3 'network|ethernet|wireless'"
    echo "    lsusb | grep -iE 'bluetooth|wlan|wifi|net'"
    echo "    ip link show"
    echo "    sudo iw dev # (for WiFi details)"
    echo "  Audio:"
    echo "    lspci -nnk | grep -iA3 audio"
    echo "    aplay -l"
    echo "    # To find codec for card 0: cat /proc/asound/card0/codec#0"
    echo "  Ports / Thunderbolt:"
    echo "    lsusb -tv # Tree view of USB devices and hubs"
    echo "    lspci | grep -i thunderbolt"
    echo "    # If 'bolt' package is installed: boltctl list"
    echo "  Battery:"
    echo "    upower -e # List power devices"
    echo "    upower -i /org/freedesktop/UPower/devices/battery_BAT0 # (Replace BAT0 if needed)"
    echo ""
    echo "Remember to cross-reference with 'sudo dmidecode' output for system/board info."
    echo "Physical inspection or manufacturer specifications might be needed for some details."
    echo "---------------------------------------------"
  '';
}
