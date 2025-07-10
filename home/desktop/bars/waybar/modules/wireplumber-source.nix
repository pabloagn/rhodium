{
  "wireplumber#source" = {
    node-type = "Audio/Source";
    format = "◌ {volume}% {icon}";
    format-muted = "◌ {volume}% [⌽]";
    format-icons = ["[-]" "[=]" "[≡]" "[≣]"];
    on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
    on-click-right = "helvum";
    scroll-step = 1;
    states = {
      warning = 75;
      critical = 100;
    };
    tooltip = true;
    tooltip-format = ''
      Recording Device
      ━━━━━━━━━━━━━━━━━━
      •Device ⟶ {node_name}
      • Volume ⟶ {volume}%
    '';
  };
}
