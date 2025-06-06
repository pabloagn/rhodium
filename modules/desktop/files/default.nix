{ ... }:

{
  imports = [
    ./thunar.nix
  ];

  services.gvfs.enable = true; # Mount, trash, etc
  services.tumbler.enable = true; # Thumbnail support for images
}
