# home/development/languages/rust.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.rust;
in
{
  options.home.development.languages.rust = {
    enable = mkEnableOption "Enable Rust development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Rust toolchain manager (includes rustc, cargo, rustfmt, clippy management)
      rustup

      # Language Server (managed by rustup typically)
      # rust-analyzer # Can be installed via `rustup component add rust-analyzer`
      # If you prefer a Nix-managed rust-analyzer:
      # rust-analyzer

      # Additional Cargo tools
      cargo-edit # For managing Cargo.toml dependencies (cargo add/rm/upgrade)
      cargo-watch # For watching files and re-running cargo commands
      cargo-audit # For auditing dependencies for security vulnerabilities
      cargo-outdated # To check for outdated dependencies
      # cargo-expand # To expand macros

      # TOML Linter/Formatter (for Cargo.toml)
      taplo-cli
    ];
    # Recommended: After enabling, run `rustup toolchain install stable` (or other channels)
    # and `rustup component add rust-analyzer clippy rustfmt`.
  };
}
