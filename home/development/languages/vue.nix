{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Vue ---
    vue-language-server
  ];
}
