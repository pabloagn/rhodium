# home/development/languages/rust.nix

{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.rhodium.home.development.languages.rust;
in
{
  options.rhodium.home.development.languages.rust = {
    enable = mkEnableOption "Enable Rust development environment (Home Manager)";

    toolchain = mkOption {
      type = types.package;
      default = pkgs.rustup;
      description = "Rust toolchain (e.g., pkgs.rustup or a specific rust-bin).";
      example = literalExpression "pkgs.rust-bin.stable.latest.default";
    };

    cargoTools = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        cargo-edit
        cargo-watch
        cargo-audit
        cargo-outdated
        cargo-expand
      ];
      description = "Additional Cargo ecosystem tools.";
    };

    formattersLinters = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        taplo-cli
      ];
      description = "Formatters and linters for Rust projects (e.g., for TOML).";
    };

    extraTools = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = "Additional Rust-related tools.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.toolchain ]
      ++ cfg.cargoTools
      ++ cfg.formattersLinters
      ++ cfg.extraTools;
  };
}
