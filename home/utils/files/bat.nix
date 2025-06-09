{ config, ... }:

{
  programs.bat = {
    enable = true;
    themes = {
      tokyonight_night = {
        src = config.themes.tokyonight.src;
        file = config.themes.tokyonight.sublime.night;
      };
    };
    config = {
      style = "plain";
      theme = "tokyonight_night";
    };
  };
}
