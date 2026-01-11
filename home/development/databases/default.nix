{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Databases ---
    redis
    postgresql
    dbeaver-bin

    # --- TUI Clients ---
    rainfrog # Database management TUI for Postgres, MySQL, SQLite
    harlequin # Modern SQL IDE for terminal
    gobang # Cross-platform database management TUI
    lazysql # Database management TUI in Go
  ];
}
