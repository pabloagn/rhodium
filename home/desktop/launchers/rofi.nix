{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      kb-repeat-delay = 250;
      kb-repeat-rate = 60;
    };
  };

  xdg.configFile = {
    # "rofi/config.rasi" = { source = ./rofi/config.rasi; };
    "rofi/themes/chiaroscuro.rasi" = { source = ./rofi/themes/chiaroscuro.rasi; };
  };
}
