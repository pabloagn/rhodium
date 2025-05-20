# home/development/languages/sql.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.sql;
in
{
  options.rhodium.home.development.languages.sql = {
    enable = mkEnableOption "Enable SQL development tools (Home Manager)";

    languageServersLintersFormatters = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        sqlfluff
        sqls
      ];
      description = "SQL Language Servers, Linters, and Formatters.";
    };

    databaseCLIs = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        sqlite
        mycli
        pgcli
      ];
      description = "Command-line interfaces for various databases.";
      example = literalExpression "[ pkgs.sqlite pkgs.postgresql pkgs.mariadb ]";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Additional SQL-related tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = cfg.languageServersLintersFormatters
      ++ cfg.databaseCLIs
      ++ cfg.extraTools;
  };
}
