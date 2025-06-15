{
  config,
  pkgs,
  ...
}: let
  iconTokens = config.theme.icons.iconsNerdFont;
  colorTokens = config.theme.colors;
in {
  programs.ghostty = {
    themes = {
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
      kanso = {
        # Basic
        background = "#090E13";
        foreground = "#c5c9c7";
        selection-background = "#22262D";
        selection-foreground = "#c5c9c7";
        # Cursor
        cursor-color = "#c5c9c7";
        cursor-text = "#090E13";
        # Terminal colors
        palette = [
          "0=#090E13"
          "1=#c4746e"
          "2=#8a9a7b"
          "3=#c4b28a"
          "4=#8ba4b0"
          "5=#a292a3"
          "6=#8ea4a2"
          "7=#a4a7a4"
          "8=#5C6066"
          "9=#e46876"
          "10=#87a987"
          "11=#e6c384"
          "12=#7fb4ca"
          "13=#938aa9"
          "14=#7aa89f"
          "15=#c5c9c7"
        ];
      };
    };
  };
}
