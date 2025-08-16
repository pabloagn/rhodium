{ ... }:
{
  programs.bat = {
    enable = true;

    themes = {
      kanso_zen = ./bat/kanso-zen.tmTheme;
      catpuccin_mnocha = ./bat/catppuccin-mocha.tmTheme;
      tokio_night = ./bat/tokyonight-night.tmTheme;
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
