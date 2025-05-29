{ config, pkgs, ... }:
let
  iconTokens = config.theme.icons.iconsNerdFont;
  colorTokens = config.theme.colors;
in
{
  programs.ghostty = {
    themes = {
      # TODO:Inject tokens
      chiaroscuro = {
        # Basic
        background = "#080D0F";
        foreground = "#cdd6f4";
        selection-background = "#f5e0dc";
        selection-foreground = "#1e1e2e";

        # Cursor
        cursor-color = "#f5e0dc";
        cursor-text = "#1e1e2e";

        # Terminal colors
        palette = [
          "0=#45475a"
          "1=#f38ba8"
          "2=#7C997D"
          "3=#CDB9A0"
          "4=#748390"
          "5=#f5c2e7"
          "6=#CDB9A0"
          "7=#bac2de"
          "8=#585b70"
          "9=#f38ba8"
          "10=#7C997D"
          "11=#CDB9A0"
          "12=#748390"
          "13=#f5c2e7"
          "14=#CDB9A0"
          "15=#a6adc8"
        ];
      };
    };
  };
}
