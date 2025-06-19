{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wireplumber # Session manager for pipewire
    pavucontrol # GUI audio control
    playerctl # Media player control
  ];

  # rtkit
  security.rtkit.enable = true; # Required by PulseAudio and PipeWire to acquire realtime priority

  # Pipewire
  services = {
    pulseaudio.enable = false; # We disable native pulse audio and let pipewire handle it instead
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;

      pulse.enable = true; # Enable pulse from pipewire
      jack.enable = true;
    };
  };
}
