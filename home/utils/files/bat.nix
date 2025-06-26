{targetTheme, ...}: {
  programs.bat = {
    enable = true;

    themes = {
      tokyonight_night = {
        inherit (targetTheme.tokyonight_night) src;
        file = targetTheme.tokyonight_night.files.bat;
      };
      kanso_zen = {
        inherit (targetTheme.kanso-zen) src;
        file = targetTheme.kanso-zen.files.bat;
      };
    };

    config = {
      style = "plain";
      theme = "kanso_zen";
    };
  };

  xdg.configFile."bat/syntaxes/Just.sublime-syntax" = {
    source = ./bat/syntaxes/Just.sublime-syntax;
    force = true;
  };

  xdg.configFile."bat/syntaxes/KDL.sublime-syntax" = {
    source = ./bat/syntaxes/KDL.sublime-syntax;
    force = true;
  };
  xdg.configFile."bat/syntaxes/nushell.sublime-syntax" = {
    source = ./bat/syntaxes/nushell.sublime-syntax;
    force = true;
  };
}
