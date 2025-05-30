
# TODO: We need to double check this since we have 3 different services declared here.

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # TODO: Check if we need this
    wireplumber
  ];

  # Pulseaudio
  services.pulseaudio.enable = false;

  # rtkit
  # Required by PulseAudio and PipeWire to acquire realtime priority
  security.rtkit.enable = true;

  # Pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
