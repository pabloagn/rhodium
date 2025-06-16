{pkgs, ...}: {
  home.packages = with pkgs; [
    # Image manipulation and viewing
    imagemagick # Image manipulation toolkit
    chafa # Terminal image viewer
    ffmpegthumbnailer # For video previews
    exiftool # Read and write metadata from and to images
    ueberzugpp # Write images on terminal on wayland (kitty, etc)
  ];
}
