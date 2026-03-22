{
  pkgs,
  ...
}:
{
  # Steam
  # Uses the NixOS module (programs.steam) which handles:
  # - FHS environment with proper graphics library injection
  # - hardware.graphics.enable + enable32Bit (already set in niri/intel.nix, merges fine)
  # - hardware.steam-hardware.enable (udev rules for controllers)
  # - uinput kernel module loading
  # - 32-bit PulseAudio/PipeWire support
  programs.steam = {
    enable = true;

    # GE-Proton for better game compatibility (declarative, appears in Steam's Compatibility menu)
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    # Translate X11 input events to uinput for Steam Input on Wayland (Niri)
    extest.enable = true;

    # Winetricks commands on Proton prefixes
    protontricks.enable = true;

    # Firewall rules for LAN features (optional, enable if needed)
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Gamescope: nested Wayland compositor for per-game use via Steam launch options
  # Usage: gamescope -W 1920 -H 1080 -f -- %command%
  # Do NOT set capSysNice = true (known broken for nested/FHS use)
  programs.gamescope = {
    enable = true;
    capSysNice = false;
  };

  # GameMode: on-demand CPU/GPU performance optimization
  # Usage in Steam launch options: gamemoderun %command%
  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };

  # Performance overlay and tools
  environment.systemPackages = with pkgs; [
    mangohud
  ];
}
