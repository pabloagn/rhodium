{pkgs, ...}: {
  home.packages = with pkgs; [
    blender
    figma-linux # Unofficial Figma client for Linux
    inkscape
    gimp3-with-plugins
  ];
}
