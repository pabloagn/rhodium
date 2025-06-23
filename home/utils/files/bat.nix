{targetTheme, ...}: {
  programs.bat = {
    enable = true;

    themes = {
      tokyonight_night = {
        inherit (targetTheme.tokyonight_night) src;
        file = targetTheme.tokyonight_night.files.bat;
      };
      kanso-zen = {
        inherit (targetTheme.kanso-zen) src;
        file = targetTheme.kanso-zen.files.bat;
      };
    };

    config = {
      style = "plain";
      theme = "kanso-zen";
    };
  };
}
