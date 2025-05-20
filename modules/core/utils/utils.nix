# modules/core/utils/utils.nix
# TODO: We need to completely check this since there are some packages that do not exist

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # General tools
    jq              # JSON processor
    ripgrep         # Fast grep alternative
    fd              # Fast find alternative
    htop            # Interactive process viewer
    curl            # Command-line tool for transferring data with URL syntax
    wget            # Non-interactive network downloader
    git             # Version control system
    unzip           # For extracting zip files
    p7zip           # For 7zip archives

    # System tools
    lshw            # List hardware
    lscpu           # List CPU information
    lspci           # List PCI devices
    lsusb           # List USB devices
    lsblk           # List block devices
    dmidecode       # Display detailed system hardware information
    coreutils       # Coreutils
    procps          # Process information
    pciutils        # PCI utilities
    usbutils        # USB utilities
    read-edid       # Read EDID information
    alsa-utils      # ALSA utilities
    libusb          # USB library
    libpci          # PCI library
    libusb-compat   # USB compatibility library
    libusb-devel    # USB development library
    libinput        # Input library
    smartmontools   # Smartmontools
    mesa-utils      # Mesa utilities
    iw              # Wireless tools
  ];
}
