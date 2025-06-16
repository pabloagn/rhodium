{...}: {
  services.xserver = {
    enable = true;
  };
  services.getty.autologinUser = "";
}
