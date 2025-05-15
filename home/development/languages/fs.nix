{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.fs;
in
{
  options.home.development.languages.fs = {
    enable = mkEnableOption "Enable F# development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # .NET SDK (includes F# compiler and tools)
      dotnet-sdk # Or a specific version like dotnet-sdk_8_0

      # Language Server (FSAutoComplete is often part of Ionide or editor extensions)
      # The .NET SDK provides some LSP capabilities.
      # fsautocomplete # If a standalone package is available and preferred.
    ];
  };
}
