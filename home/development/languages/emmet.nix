{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Emmet ---
    emmet-ls
  ];
}
