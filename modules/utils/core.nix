{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mesa
    libva
    gdb # GNU Project Debugger
    libGL
    libGLU
    glib
    gsettings-desktop-schemas

    # Core system utilities
    uutils-coreutils-noprefix
    coreutils
    util-linux # Includes lscpu
    gawk # GNU's awk

    # Build essentials
    gnumake
    gnutls
    gcc
    pkg-config

    # Version control
    git
    hwinfo # Hardware detection tool from openSUSE

    # Hardware information tools
    lshw # List hardware
    pciutils # lspci
    lshw # List hardware
    inxi # My swiss army knife
    usbutils # lsusb
    dmidecode # System hardware details
    smartmontools # S.M.A.R.T. monitoring
    read-edid # EDID information

    # Audio tools
    alsa-utils # ALSA utilities
  ];
}
