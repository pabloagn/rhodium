{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.home.development.languages.cs;
in
{
  options.home.development.languages.cs = {
    enable = mkEnableOption "Enable C# development environment (Home Manager)";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # .NET SDK (includes C# compiler)
      dotnet-sdk # Or a specific version like dotnet-sdk_8_0

      # Language Servers
      csharp-ls
      # omnisharp-roslyn # Often installed as an editor extension
    ];
  };
}
