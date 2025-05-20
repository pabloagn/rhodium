# modules/development/languages/swift.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.swift;
in
{
  options.rhodium.system.development.languages.swift = {
    enable = mkEnableOption "Enable Swift development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Swift Compiler and Toolchain
      swift # This should provide swiftc, swift build, etc.

      # Language Server (SourceKit-LSP)
      # sourcekit-lsp # Usually bundled with the Swift toolchain.
      # If not, it might be a separate package or built from source.
      # Check nixpkgs for the best way to get sourcekit-lsp if `swift` doesn't include it.
    ];
  };
}
