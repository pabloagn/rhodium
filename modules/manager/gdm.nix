{...}: {
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
  security.pam.services.gdm.enableGnomeKeyring = true;
}
