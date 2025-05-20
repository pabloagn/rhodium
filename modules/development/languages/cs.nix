# modules/development/languages/cs.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.cs;
in
{
  options.rhodium.system.development.languages.cs = {
    enable = mkEnableOption "Enable C# development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # .NET SDK (includes C# compiler)
      dotnet-sdk # Or a specific version like dotnet-sdk_8_0

      # Language Servers
      csharp-ls
      # omnisharp-roslyn # Often installed as an editor extension, but a package might exist
    ];
  };
}
