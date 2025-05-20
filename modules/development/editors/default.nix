# modules/development/editors/default.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.editors;
in
{
  imports = [
    ./vim.nix
    ./nvim.nix
  ];

  options.rhodium.system.development.editors = {
    enable = mkEnableOption "Enable all editors";
  };

  config = mkIf cfg.enable {
  };
}
