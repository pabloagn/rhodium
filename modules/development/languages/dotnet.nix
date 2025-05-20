# modules/development/languages/dotnet.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.dotnet;
in
{
  options.rhodium.system.development.languages.dotnet = {
    enable = mkEnableOption "Enable .NET development environment (SDK)";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # .NET SDK (includes runtimes for .NET Core, ASP.NET Core)
      dotnet-sdk # Or a specific version like dotnet-sdk_8_0
      # You might want to add specific runtimes if not developing:
      # dotnet-runtime
      # aspnetcore-runtime
    ];
  };
}
