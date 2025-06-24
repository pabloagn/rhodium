{...}: {
  # NOTE: See https://wiki.nixos.org/wiki/Appimage
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
