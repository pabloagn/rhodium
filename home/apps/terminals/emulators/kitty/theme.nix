{ chiaroscuroTheme, ... }:

{
  programs.kitty = {
    settings = {
      background_opacity = 0.80;
    } // chiaroscuroTheme.kitty;
  };
}
