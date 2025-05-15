# modules/development/languages/sql.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.sql;
in
{
  options.modules.development.languages.sql = {
    enable = mkEnableOption "Enable SQL development tools";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # SQL Language Servers / Linters / Formatters
      sqlfluff # Linter and formatter for SQL, can also act as LSP
      sqls # SQL Language Server

      # Database CLIs (examples, add as needed)
      # postgresql # For psql
      # sqlite # For sqlite3
      # mycli # CLI for MySQL/MariaDB with auto-completion and syntax highlighting
      # pgcli # CLI for PostgreSQL with auto-completion and syntax highlighting
    ];
  };
}
