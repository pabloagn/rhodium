{ pkgs, ... }:

{
  programs.regreet = {
    enable = true;
    settings = {
      background = {
        path = "/etc/regreet/wallpaper-01.jpg";
        fit = "Cover";
      };
      
      GTK = {
        application_prefer_dark_theme = true;
        # cursor_theme_name = "Bibata-Modern-Ice";
        # font_name = "Inter 12";
        # icon_theme_name = "Papirus-Dark";
        # theme_name = "Adwaita-dark";
      };
      
      commands = {
        reboot = [ "systemctl" "reboot" ];
        poweroff = [ "systemctl" "poweroff" ];
      };
    };
  };
  
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "env GTK_USE_PORTAL=0 GDK_DEBUG=no-portals ${pkgs.hyprland}/bin/Hyprland --config /etc/greetd/hyprland.conf";
        user = "greeter";
      };
    };
  };
  
  # Create Hyprland config specifically for ReGreet
  environment.etc."greetd/hyprland.conf".text = ''
    # ReGreet config - based on docs
    exec-once = ${pkgs.greetd.regreet}/bin/regreet; hyprctl dispatch exit
    
    misc {
      disable_hyprland_logo = true
      disable_splash_rendering = true
      disable_hyprland_qtutils_check = true
    }
    # Disable animations for faster loading
    animations {
      enabled = false
    }
    # Environment variables to prevent startup delays
    env = GTK_USE_PORTAL,0
    env = GDG_DEBUG,no-portals
    # Monitor configuration - adjust for your setup
    monitor = eDP-1,2880x1620@120,0x0,1.5
    monitor = HDMI-A-1,3840x2160@60,0x0,1.5
  '';
  
  # Create systemd tmpfiles for ReGreet state and logs
  systemd.tmpfiles.rules = [
    "d /var/lib/regreet 0755 greeter greeter - -"
    "d /var/log/regreet 0755 greeter greeter - -"
  ];
  
  # Required packages for ReGreet
  environment.systemPackages = with pkgs; [
    greetd.regreet
  ];
  
  # Enable required services
  security.pam.services.greetd.enableGnomeKeyring = true;
  
  # Write the wallpaper
  environment.etc."regreet/wallpaper-01.jpg".source = ../../home/assets/wallpapers/dante/wallpaper-01.jpg;

  services.displayManager.sessionPackages = [ pkgs.hyprland ];
  environment.pathsToLink = [ "/share/xsessions" "/share/wayland-sessions" ];
}
