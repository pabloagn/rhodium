{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Pass & Gnupg ---
    # Required by Proton Bridge
    pass
    gnupg
  ];
}
