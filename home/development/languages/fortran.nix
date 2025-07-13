{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Fortran ---
    fortls
    fprettify # Formatter
  ];
}
