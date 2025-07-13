{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pamixer # Pulseaudio command line mixer
    pavucontrol # GUI audio control
    playerctl # Media player control
    wireplumber # Session manager for pipewire
  ];

  # rtkit
  security.rtkit.enable = true; # NOTE: Required by PulseAudio and PipeWire to acquire realtime priority

  # Pipewire
  services = {
    pulseaudio.enable = false; # NOTE: We disable native pulse audio and let pipewire handle it instead
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true; # NOTE: Enable pulse from pipewire
      wireplumber.enable = true;
    };
  };
}
