{ ... }:
{
  programs.zed-editor = {
    userSettings = {
      theme = {
        mode = "system";
        # dark = "Kanso Zen (Blurred)";
        # TODO: Fix the out of focus top bar. Current gray is uggly AF.
        # light = "Kanso Pearl (Blurred)";
        dark = "Kanso Zen (Borderless)";
        light = "Kanso Pearl (Borderless)";
      };
      icon_theme = "Catppuccin Mocha";

      # --- Panel Borders ---
      # The Borderless theme sets all borders to 00 alpha (invisible).
      # Override with the theme's own border colors (from Kanso Zen non-borderless)
      # to add subtle panel delimiters while keeping the borderless base.
      "experimental.theme_overrides" = {
        "border" = "#22262D";
        "border.variant" = "#22262D";
        "border.focused" = "#8ba4b080";
        "border.selected" = "#949fb580";
        "border.transparent" = "#090E1300";
        "border.disabled" = "#5C606600";
      };
    };
  };
}
