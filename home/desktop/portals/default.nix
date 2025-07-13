{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # GTK theme requirements
    sassc
    gtk-engine-murrine
    gnome-themes-extra
    adwaita-icon-theme

    # Qt themes
    (catppuccin-kvantum.override {
      variant = "mocha";
      accent = "mauve";
    })
  ];

  # GTK
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
      size = 24;
    };
  };

  # Qt
  qt = {
    enable = true;
    platformTheme.name = "gtk"; # Follow GTK theme
    style = {
      name = "kvantum";
      package = pkgs.libsForQt5.qtstyleplugin-kvantum;
    };
  };
}
