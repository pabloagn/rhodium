{ ... }:
{
  programs.swaylock = {
    enable = false;
  };
  xdg.configFile."swaylock/config".source = ./swaylock/config;
}
