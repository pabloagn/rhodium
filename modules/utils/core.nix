{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Core system utilities
    uutils-coreutils-noprefix
    coreutils
    util-linux # Includes lscpu
    gawk # GNU's awk

    # Build essentials
    gnumake
    gcc
    pkg-config

    # Version control
    git

    # Hardware information tools
    lshw # List hardware
    pciutils # lspci
    usbutils # lsusb
    dmidecode # System hardware details
    smartmontools # S.M.A.R.T. monitoring
    read-edid # EDID information

    # Graphics/Display tools
    mesa-utils # glxinfo, glxgears

    # Audio tools
    alsa-utils # ALSA utilities
  ];
}
