{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.manager.tty;
in {
  options.manager.tty = {
    enable = mkEnableOption "TTY-based login with X server";
  };
  
  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
    };
    services.getty.autologinUser = "";
  };
}
