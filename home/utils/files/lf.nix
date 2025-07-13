{ ... }:
{
  programs.lf = {
    enable = false;
  };

  xdg.configFile."lf/lfrc" = {
    source = ./lf/lfrc;
  };

  xdg.configFile."lf/colors" = {
    source = ./lf/colors;
  };

  xdg.configFile."lf/cleaner" = {
    source = ./lf/cleaner;
  };

  xdg.configFile."lf/previewer" = {
    source = ./lf/previewer;
  };

  xdg.configFile."lf/icons" = {
    # enable = config.programs.lf.enable;
    source = ./lf/icons;
  };
}
