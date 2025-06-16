{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mesa # Open source 3D graphics library
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
    dool # System statistics tool (dstat replacement)

    # Audio tools
    alsa-utils # ALSA utilities
  ];
}
