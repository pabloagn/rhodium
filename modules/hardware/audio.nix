{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pamixer # Pulseaudio command line mixer
    pavucontrol # GUI audio control
    playerctl # Media player control
    wireplumber # Session manager for pipewire
  ];

  # rtkit
  security.rtkit = {
    enable = true; # NOTE: Required by PulseAudio and PipeWire to acquire realtime priority
  };

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

      # WirePlumber Bluetooth configuration for better headset support
      # Reference: https://wiki.nixos.org/wiki/PipeWire
      # Reference: https://pipewire.pages.freedesktop.org/wireplumber/daemon/configuration/bluetooth.html
      wireplumber.extraConfig = {
        # Bluetooth codec and role configuration
        "10-bluez" = {
          "monitor.bluez.properties" = {
            "bluez5.enable-sbc-xq" = true; # High-quality SBC codec
            "bluez5.enable-msbc" = true; # Wideband speech codec for calls
            "bluez5.enable-hw-volume" = true; # Hardware volume control
            # Enable both A2DP (stereo) and HSP/HFP (headset) roles
            # IMPORTANT: Must include a2dp roles or stereo playback breaks
            "bluez5.roles" = [
              "a2dp_sink"
              "a2dp_source"
              "hsp_hs"
              "hsp_ag"
              "hfp_hf"
              "hfp_ag"
            ];
          };
        };
        # Bluetooth profile switching policy
        # Disabling auto-switch keeps stereo audio; manual switch needed for mic
        "11-bluetooth-policy" = {
          "wireplumber.settings" = {
            "bluetooth.autoswitch-to-headset-profile" = false;
          };
        };
      };
    };
    mpd = {
      enable = true; # Flexible, powerful daemon for playing music
    };
  };
}
