# modules/core/hardware/audio.nix

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wireplumber
  ];

  # Pulseaudio
  hardware.pulseaudio.enable = false;

  # rtkit
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
