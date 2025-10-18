{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Databases ---
    redis
    postgresql
    dbeaver-bin

    # --- Utils ---
    rainfrog # Database management TUI
  ];
}
