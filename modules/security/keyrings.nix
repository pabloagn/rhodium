{...}: {
  services.gnome.gnome-keyring.enable = true;
  
  security.pam.services = {
    login.enableGnomeKeyring = true; # Enable Gnome keyring on login # FIX: This is flimsy. Sometimes it unlocks, sometimes it does not.
    hyprlock.enableGnomeKeyring = true; # Enable unlocking keyring on unlock lockscreen
  };
}
