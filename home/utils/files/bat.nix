{ targetTheme, ... }:

{
  programs.bat = {
    enable = true;

    themes = {
      tokyonight_night = {
        inherit (targetTheme.tokyonight_night) src;
        file = targetTheme.tokyonight_night.files.bat;
      };
    };

    config = {
      style = "plain";
      theme = "tokyonight_night";
    };
  };
}

