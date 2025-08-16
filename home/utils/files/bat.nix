{ ... }:
{
  programs.bat = {
    enable = true;

    themes = {
      kanso_zen = {
        src = ./.;
        file = "bat/kanso-zen.tmTheme";
      };

      catppuccin_mocha = {
        src = ./.;
        file = "bat/catppuccin-mocha.tmTheme";
      };

      tokyonight = {
        src = ./.;
        file = "bat/tokyonight-night.tmTheme";
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
