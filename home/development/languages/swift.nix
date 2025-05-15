# home/development/languages/swift.nix
{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.swift;
in
{
  options.home.development.languages.swift = {
    enable = mkEnableOption "Enable Swift development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Swift Compiler and Toolchain
      swift # This should provide swiftc, swift build, etc.

      # Language Server (SourceKit-LSP)
      # sourcekit-lsp # Usually bundled with the Swift toolchain.
      # Check nixpkgs for the best way to get sourcekit-lsp if `swift` doesn't include it.
    ];
  };
}
