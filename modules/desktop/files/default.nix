{ ... }:

{
  imports = [
    ./thunar.nix
  ];

  services = {
    gvfs.enable = true; # Mount, trash, etc
    tumbler.enable = true; # Thumbnail support for images
  };
}
