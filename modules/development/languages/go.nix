# modules/development/languages/go.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.go;
in
{
  options.rhodium.system.development.languages.go = {
    enable = mkEnableOption "Enable Go development environment";
    version = mkOption {
      type = types.nullOr types.str;
      default = null; # e.g., "1.21" for pkgs.go_1_21, null for pkgs.go
      description = "Specify Go version. If null, uses default pkgs.go.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Go Compiler and Tools
      (if cfg.version == null then go else pkgs."go_${builtins.replaceStrings ["."] ["_"] cfg.version}")

      # Language Server
      gopls # Official Go language server (from go-tools or standalone)
      # go-tools # Collection of tools including gopls

      # Linters
      golangci-lint

      # Formatters (go fmt is included with Go)
      gofumpt
      goimports-reviser # Sorts imports and formats

      # Other useful tools
      # delve # Go debugger
      # gotools.impl # For interface stub generation
    ];
  };
}
