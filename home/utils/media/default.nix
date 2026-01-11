{ pkgs, ... }:
{
  home.packages = with pkgs; [
    chafa # Terminal image viewer (ANSI/text art)
    timg # Terminal image viewer with sixel support
    exiftool # Read and write metadata from and to images
    ffmpegthumbnailer # For video previews
    imagemagick # Image manipulation toolkit
    libwebp # Tools for WebP images
    ueberzugpp # Write images on terminal on wayland (kitty, etc)
  ];
}
