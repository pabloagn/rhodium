# modules/core/hardware/audio.nix

{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.system.hardware.audio;
in
{
  options.rhodium.system.hardware.audio = {
    enable = mkEnableOption "Rhodium audio hardware configuration (PipeWire)";

    pipewire = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable PipeWire as the audio server.";
      };

      alsa.enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable ALSA support in PipeWire.";
      };

      alsa.support32Bit = mkOption {
        type = types.bool;
        default = true;
        description = "Enable 32-bit ALSA support in PipeWire.";
      };

      pulse.enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable PulseAudio compatibility layer in PipeWire.";
      };

      jack.enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable JACK compatibility layer in PipeWire.";
      };
    };

    rtkit.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable RealtimeKit for low-latency audio scheduling.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = mkIf cfg.pipewire.enable [
      pkgs.wireplumber
    ];

    hardware.pulseaudio.enable = mkIf cfg.pipewire.enable false;

    security.rtkit.enable = cfg.rtkit.enable;

    services.pipewire = {
      enable = cfg.pipewire.enable;
      alsa = {
        enable = cfg.pipewire.alsa.enable;
        support32Bit = cfg.pipewire.alsa.support32Bit;
      };
      pulse.enable = cfg.pipewire.pulse.enable;
      jack.enable = cfg.pipewire.jack.enable;
    };
  };
}
