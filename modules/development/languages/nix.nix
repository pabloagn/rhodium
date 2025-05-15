# modules/development/languages/nix.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.modules.development.languages.nix;
in
{
  options.modules.development.languages.nix = {
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
