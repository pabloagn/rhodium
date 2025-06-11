{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wireplumber
  ];

  services.pulseaudio.enable = false;

  # rtkit
  # Required by PulseAudio and PipeWire to acquire realtime priority
  security.rtkit.enable = true;

  # Pipewire
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true; # Enable pulse from pipewire
    jack.enable = true;
  };
}
