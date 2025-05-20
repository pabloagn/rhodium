# modules/development/editors/vim.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.editors.vim;
in

{
  options.rhodium.system.development.editors.vim = {
    enable = mkEnableOption "Enable Vim (system)";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vim
    ];
  };
}
