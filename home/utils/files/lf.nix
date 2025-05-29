{ config, pkgs, ... }:
{
  programs.lf = {
    enable = false;
  };

  xdg.configFile."lf/lfrc" = {
    source = ./lfrc;
  };

  xdg.configFile."lf/colors" = {
    source = ./colors;
  };

  xdg.configFile."lf/cleaner" = {
    source = ./cleaner;
  };

  xdg.configFile."lf/previewer" = {
    source = ./previewer;
  };

  xdg.configFile."lf/icons" = {
    # enable = config.programs.lf.enable;
    source = ./icons;
  };
}
