{
  "wireplumber#sink" = {
    node-type = "Audio/Sink";
    format = "∿ {volume}%";
    format-muted = "∅ {volume}%";
    on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
    on-click-right = "helvum";
    scroll-step = 1;
    states = {
      warning = 75;
      critical = 100;
    };
    tooltip = true;
    tooltip-format = ''
      ∿ Playback Device
      ━━━━━━━━━━━━━━━━━━
      • Device ⟶ {node_name}
      • Volume ⟶ {volume}%
    '';
  };
}
