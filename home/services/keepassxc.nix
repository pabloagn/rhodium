{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.userExtraServices.rh-keepassxc-keyring;
in {
  options.userExtraServices.rh-keepassxc-keyring = {
    enable = mkEnableOption "KeePassXC as Secret Service keyring provider";
    
    database = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "/home/user/passwords.kdbx";
      description = "Path to KeePassXC database to auto-open on start";
    };
    
    minimizeToTray = mkOption {
      type = types.bool;
      default = true;
      description = "Start minimized to system tray";
    };
  };
  
  config = mkIf cfg.enable {
    # Install KeePassXC
    home.packages = [ pkgs.keepassxc ];
    
    # Disable gnome-keyring to prevent conflicts
    services.gnome-keyring.enable = mkForce false;
    
    # KeePassXC systemd service
    systemd.user.services.keepassxc-keyring = {
      Unit = {
        Description = "KeePassXC password manager as keyring provider";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session-pre.target"];
        # Ensure it starts before applications that need secrets
        Before = ["default.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.keepassxc}/bin/keepassxc"
          + optionalString cfg.minimizeToTray " --minimize"
          + optionalString (cfg.database != null) " ${cfg.database}";
        Restart = "on-failure";
        RestartSec = 3;
        # Prevent core dumps with sensitive data
        PrivateDevices = true;
        MemoryDenyWriteExecute = true;
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
    
    # Create dbus service files to register as secret service provider
    xdg.dataFile."dbus-1/services/org.freedesktop.secrets.service".text = ''
      [D-BUS Service]
      Name=org.freedesktop.secrets
      Exec=${pkgs.keepassxc}/bin/keepassxc
    '';
    
    xdg.dataFile."dbus-1/services/org.freedesktop.impl.portal.Secret.service".text = ''
      [D-BUS Service]
      Name=org.freedesktop.impl.portal.Secret
      Exec=${pkgs.keepassxc}/bin/keepassxc
    '';
  };
}
