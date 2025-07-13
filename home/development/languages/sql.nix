{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Sql ---
    sqlfluff # Linter
    sqlite # SQLite database
    sqls # SQL language server
  ];
}
