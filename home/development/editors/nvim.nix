# home/development/editors/nvim.nix

{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.rhodium.development.editors.nvim;
in
{
  options.rhodium.development.editors.nvim = {
    enable = mkEnableOption "Rhodium's NVIM configuration";
  };

  config = mkIf (config.rhodium.development.editors.enable && cfg.enable) {
    home.packages = with pkgs; [
      nvim
    ];

    # TODO: Add configurations
  };
}
