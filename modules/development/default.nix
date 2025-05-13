# modules/development/default.nix
{ config, lib, pkgs, ... }:

with lib;
let 
  cfg = config.mySystem.categories.development;
in {
  options.mySystem.categories.development = {
    enable = mkEnableOption "development environment";
    languages.rust.enable = mkEnableOption "Rust development";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ git ];
    imports = [
      (mkIf cfg.languages.rust.enable ./languages/rust.nix)
    ];
  };
}
