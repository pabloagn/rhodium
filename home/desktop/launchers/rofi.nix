{ pkgs, userPreferences, ... }:
let
  dpiAdjustment = userPreferences.behaviour.dpiAdjustment;
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    # font = "JetBrainsMono NerdFont 14";
    extraConfig = {
      dpi = dpiAdjustment;
    };
  };

  xdg.configFile = {
    # "rofi/config.rasi" = { source = ./rofi/config.rasi; };
    "rofi/themes/chiaroscuro.rasi" = { source = ./rofi/themes/chiaroscuro.rasi; };
  };
}
