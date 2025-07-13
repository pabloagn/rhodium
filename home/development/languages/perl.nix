{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Perl ---
    perlnavigator
  ];
}
