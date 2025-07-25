{ pkgs, ... }:
{
  home.packages = with pkgs; [
    blender # 3D creation software
  ];
}

