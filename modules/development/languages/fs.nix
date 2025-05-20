# modules/development/languages/fs.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.fs;
in
{
  options.rhodium.system.development.languages.fs = {
    enable = mkEnableOption "Enable F# development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # .NET SDK (includes F# compiler and tools)
      dotnet-sdk # Or a specific version like dotnet-sdk_8_0

      # Language Server (FSAutoComplete is often part of Ionide or editor extensions)
      # The .NET SDK provides some LSP capabilities.
      # fsautocomplete # If a standalone package is available and preferred.
    ];
  };
}
