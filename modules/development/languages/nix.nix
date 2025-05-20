# modules/development/languages/nix.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.languages.nix;
in
{
  options.rhodium.system.development.languages.nix = {
    enable = mkEnableOption "Enable Nix development environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cachix
      nil
      nix-info
      nixpkgs-fmt
      sbomnix
    ];
  };
}
