# home/development/tools/terraform.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.tools.terraform;
in
{
  options.rhodium.development.tools.terraform = {
    enable = mkEnableOption "Rhodium's Terraform configuration";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      terraform
      vsh
    ];
  };
}
