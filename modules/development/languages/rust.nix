# modules/development/languages/rust.nix
{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.rust;
in
{
  options.modules.development.languages.rust = {
    enable = mkEnableOption "Enable Rust development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Rust toolchain (includes rustc, cargo, rustfmt, clippy)
      # Using rustup is recommended for managing multiple toolchains and components.
      rustup
      # Alternatively, for a fixed toolchain:
      # rust-bin.stable.latest.default (or specific versions)

      # Language Server
      rust-analyzer # (often installed via rustup component add rust-analyzer)
                    # but can also be a standalone package. rustup is preferred.

      # Additional Cargo tools
      cargo-edit # For managing Cargo.toml dependencies (cargo add/rm/upgrade)
      # cargo-watch # For watching files and re-running cargo commands
      # cargo-audit # For auditing dependencies for security vulnerabilities
      # cargo-outdated # To check for outdated dependencies

      # TOML Linter/Formatter (for Cargo.toml)
      taplo-cli
    ];

    # Recommended: After enabling, run `rustup toolchain install stable` (or other channels)
    # and `rustup component add rust-analyzer clippy rustfmt`
    # if not using a pre-packaged rust-analyzer.
    # If rustup is used, it typically manages rust-analyzer, clippy, and rustfmt.
    # If using rust-bin, rust-analyzer might need to be added separately if not bundled.
  };
}
