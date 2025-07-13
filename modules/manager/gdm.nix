{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.manager.gdm;
in
{
  options.manager.gdm = {
    enable = mkEnableOption "GDM display manager with custom configuration";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
  };
}
