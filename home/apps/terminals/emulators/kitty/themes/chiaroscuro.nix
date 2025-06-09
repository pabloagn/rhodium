{ ... }:
# TODO: Inject theme
{
  programs.kitty = {
    settings = {

      # Theme
      background_opacity = 0.80;

      # The basic colors
      foreground = "#cdd6f4";
      background = "#080D0F";
      selection_foreground = "#1e1e2e";
      selection_background = "#f5e0dc";

      # Cursor colors
      cursor = "#f5e0dc";
      cursor_text_color = "#1e1e2e";

      # URL underline color when hovering with mouse
      url_color = "#73daca";
      # url_color = "#f5e0dc";

      # Kitty window border colors
      active_border_color = "#b4befe";
      inactive_border_color = "#6c7086";
      bell_border_color = "#f9e2af";

      # OS Window titlebar colors
      wayland_titlebar_color = "system";
      macos_titlebar_color = "system";

      # Tab bar colors
      active_tab_foreground = "#11111b";
      active_tab_background = "#cba6f7";
      inactive_tab_foreground = "#cdd6f4";
      inactive_tab_background = "#181825";
      tab_bar_background = "#11111b";

      # Colors for marks (marked text in the terminal)
      mark1_foreground = "#1e1e2e";
      mark1_background = "#b4befe";
      mark2_foreground = "#1e1e2e";
      mark2_background = "#cba6f7";
      mark3_foreground = "#1e1e2e";
      mark3_background = "#74c7ec";

      # Normal
      color0 = "#15161e";
      color1 = "#f7768e";
      # color2 = "#9ece6a";
      color2 = "#6ace83";
      color3 = "#e0af68";
      color4 = "#7aa2f7";
      color5 = "#bb9af7";
      color6 = "#CDB9A0";
      # color6 = "#7dcfff";
      color7 = "#a9b1d6";

      # Bright
      color8 = "#414868";
      color9 = "#ff899d";
      # color10 = "#9fe044";
      color10 = "#44e066";
      color11 = "#faba4a";
      color12 = "#8db0ff";
      color13 = "#c7a9ff";
      # color14 = "#a4daff";
      color14 = "#CDB9A0";
      color15 = "#c0caf5";

      # Extended
      color16 = "#ff9e64";
      # color17 = "#db4b4b";
      color17 = "#cf4242";

      # # black
      # color0 = "#45475a";
      # color8 = "#585b70";
      #
      # # red
      # color1 = "#f38ba8";
      # color9 = "#f38ba8";
      #
      # # green
      # color2 = "#7C997D";
      # color10 = "#7C997D";
      #
      # # yellow
      # color3 = "#CDB9A0";
      # color11 = "#CDB9A0";
      #
      # # blue
      # color4 = "#748390";
      # color12 = "#748390";
      #
      # # magenta
      # color5 = "#f5c2e7";
      # color13 = "#f5c2e7";
      #
      # # cyan
      # color6 = "#CDB9A0";
      # color14 = "#CDB9A0";
      #
      # # white
      # color7 = "#bac2de";
      # color15 = "#a6adc8";
    };
  };
}
