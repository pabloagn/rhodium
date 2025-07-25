{ ... }:
{
  programs.zed-editor = {
    userSettings = {
      "experimental.theme_overrides" = {
        "editor.background" = "#15151f";
        "background" = "#15151f";
        "surface.background" = "#181825";
        "elevated_surface.background" = "#181825";
        "panel.background" = "#181825";
        "status_bar.background" = "#11111b";
        "title_bar.background" = "#11111b";
        "tab_bar.background" = "#11111b80";
        "tab.active_background" = "#1e1e2e";
        "tab.inactive_background" = "#0b0b11";
        "toolbar.background" = "#1e1e2e";
        syntax = {
          comment.font_style = "italic";
          "comment.doc".font_style = "italic";
        };
      };
      theme = {
        mode = "system";
        light = "Tokyo Night Light";
        dark = "Tokyo Night";
      };
      icon_theme = "Catppuccin Mocha";
    };
  };
}
