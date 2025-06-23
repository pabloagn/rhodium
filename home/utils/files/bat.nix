{targetTheme, ...}: {
  programs.bat = {
    enable = true;

    themes = {
      tokyonight_night = {
        inherit (targetTheme.tokyonight_night) src;
        file = targetTheme.tokyonight_night.files.bat;
      };
      kanso_zen = {
        inherit (targetTheme.kanso_zen) src;
        file = targetTheme.kanso_zen.files.bat;
      };
    };

    config = {
      style = "plain";
      theme = "kanso_zen";
    };
  };
}
