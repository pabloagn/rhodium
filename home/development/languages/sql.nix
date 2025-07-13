{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # --- Sql ---
    sqlfluff # Formatter
    sqlite # Sqweallite
    sqls # SQL language server
  ];
}
