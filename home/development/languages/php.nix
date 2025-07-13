{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Php ---
    intelephense # NOTE: Alternative: phpactor
  ];
}
