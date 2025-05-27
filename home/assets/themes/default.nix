{ lib, config, ... }:

{
  options.theme = lib.mkOption {
    type = lib.types.attrs;
    description = "Theme configuration";
    default = {};
  };

  config = {
    xdg.dataFile."wallpapers" = {
      source = ../wallpapers;
      recursive = true;
    };

    xdg.dataFile."icons" = {
      source = ../icons;
      recursive = true;
    };

    # Legacy compatibility symlinks
    home.file.".wallpapers" = {
      source = ../wallpapers;
      recursive = true;
    };

    home.file.".icons-local" = {
      source = ../icons;
      recursive = true;
    };
  };
}
