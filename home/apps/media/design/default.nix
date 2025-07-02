{pkgs, ...}: {
  home.packages = with pkgs; [
    blender # 3D creation software
    figma-linux # Unofficial Figma client for Linux
    inkscape # Vector graphics editor
    gimp3-with-plugins # GNU manipulation program
  ];
}
