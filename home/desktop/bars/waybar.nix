{ ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  # Harden the waybar service: prevent flapping on monitor changes
  systemd.user.services.waybar = {
    Service = {
      RestartSec = 2;
    };
    Unit = {
      StartLimitBurst = 5;
      StartLimitIntervalSec = 30;
    };
  };

  imports = [
    ./waybar/modules
  ];

  # --- Configs ---
  # xdg.configFile."waybar/config.jsonc" = {
  #   source = ./waybar/config.jsonc;
  #   force = true;
  # };

  xdg.configFile."waybar/style.css" = {
    source = ./waybar/style.css;
    force = true;
  };

  # --- Data ---
  # NOTE: Modify this file for timezone cherry-picking for custom waybar clock module
  # xdg.dataFile."waybar/modules/clock/timezones.jsonc" = {
  #   source = ./waybar/modules/clock/timezones.jsonc;
  #   force = true;
  # };
}
