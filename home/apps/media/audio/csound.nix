{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Music Production ---
    csound
  ];
}

