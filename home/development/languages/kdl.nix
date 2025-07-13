{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Kdl ---
    kdlfmt
  ];
}
