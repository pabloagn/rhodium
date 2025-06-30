{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mesa # Open source 3D graphics library
    libva # Video acceleration API
    gdb # GNU Project Debugger
    libGL
    libGLU
    glib
    gsettings-desktop-schemas

    # Core system utilities
    uutils-coreutils-noprefix # An improvement over coreutils
    coreutils # Basic GNU tools
    util-linux # Includes lscpu

    # Build essentials
    gnumake # Make files
    gnutls # GNU transport layer security library
    gcc # GNU compiler collection
    pkg-config # Package information finder

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
    upower # D-Bus service for power management

    # Audio tools
    alsa-utils # ALSA utilities

    # Hardware testing
    stress # Perform stress tests on CPU
  ];
}
