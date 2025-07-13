{
  pkgs,
  userPreferences,
  ...
}:
let
  dpiAdjustment = userPreferences.behaviour.dpiAdjustment;
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    # package = pkgs.rofi-wayland;
    # font = "JetBrainsMono NerdFont 14";
    extraConfig = {
      dpi = dpiAdjustment;
    };
  };

  xdg.configFile = {
    "rofi/themes/chiaroscuro.rasi" = {
      source = ./rofi/themes/chiaroscuro.rasi;
    };
  };
}
