{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Crystal ---
    crystal
    icr
    # crystalline
  ];
}
