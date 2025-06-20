{...}: {
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  # Enable unlocking keyring on unlock lockscreen
  security.pam.services.hyprlock = {
    enableGnomeKeyring = true;
  };
}
