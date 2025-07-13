{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- F# ---
    fsautocomplete
  ];
}
