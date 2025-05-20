# modules/development/editors/nvim.nix

{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.rhodium.system.development.editors.nvim;
in

{
  options.rhodium.system.development.editors.nvim = {
    enable = mkEnableOption "Enable Neovim (system)";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      neovim
    ];
  };
}
