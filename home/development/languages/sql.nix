# home/development/languages/sql.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.sql;
in
{
  options.home.development.languages.sql = {
    enable = mkEnableOption "Enable SQL development tools (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # SQL Language Servers / Linters / Formatters
      sqlfluff # Linter and formatter for SQL, can also act as LSP
      sqls # SQL Language Server

      # Database CLIs (examples, add as needed)
      sqlite # For sqlite3
      # postgresql # For psql (if you want the client tools)
      mycli # CLI for MySQL/MariaDB with auto-completion and syntax highlighting
      pgcli # CLI for PostgreSQL with auto-completion and syntax highlighting
    ];
  };
}
