{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Glsl ---
    glslls
  ];
}
