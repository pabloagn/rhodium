{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.dotnet;
in
{
  options.home.development.languages.dotnet = {
    enable = mkEnableOption "Enable .NET development environment (SDK) (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # .NET SDK (includes runtimes for .NET Core, ASP.NET Core)
      dotnet-sdk # Or a specific version like dotnet-sdk_8_0
    ];
  };
}
