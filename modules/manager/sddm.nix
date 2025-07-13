{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.manager.sddm;
in
{
  options.manager.sddm = {
    enable = mkEnableOption "SDDM display manager with custom configuration";
  };

  config = mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-mocha";
      settings = {
        General = {
          DefaultSession = "hyprland";
          DisplayServer = "wayland";
          GreeterEnvironment = "QT_WAYLAND_FORCE_DPI=physical,QT_WAYLAND_DISABLE_WINDOWDECORATION=1";
          Numlock = "on";
          RememberLastUser = true;
          RememberLastSession = true;
          LoginTimeout = 60;
          SessionTimeout = 30;
        };
        Users = {
          MinimumUid = 1000;
          MaximumUid = 60000;
          HideUsers = "";
          HideShells = "/bin/false,/usr/bin/nologin,/sbin/nologin";
          RememberLastUser = true;
        };
        Wayland = {
          SessionDir = "/run/current-system/sw/share/wayland-sessions";
          CompositorCommand = "kwin_wayland --no-lockscreen --no-global-shortcuts --locale1";
        };
        X11 = {
          SessionDir = "/run/current-system/sw/share/xsessions";
          XephyrPath = "/run/current-system/sw/bin/Xephyr";
          DisplayCommand = "/run/current-system/sw/bin/sddm-helper --start-server";
          DisplayStopCommand = "/run/current-system/sw/bin/sddm-helper --stop-server";
        };
      };
    };
    environment.systemPackages = with pkgs; [
      (catppuccin-sddm.override {
        flavor = "mocha";
        font = "Inter";
        fontSize = "12";
        background = "${./../../home/assets/wallpapers/dante/wallpaper-01.jpg}";
        loginBackground = true;
      })
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5.qtsvg
      libsForQt5.qt5.qtmultimedia
      inter
    ];
    environment.etc."sddm/wallpaper.jpg".source = ../../home/assets/wallpapers/dante/wallpaper-01.jpg;
    services.xserver = {
      enable = true;
      displayManager.sessionPackages = [ pkgs.hyprland ];
    };
    qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = "kvantum";
    };
    security.pam.services.sddm.enableGnomeKeyring = true;
    security.pam.services.sddm-greeter.enableGnomeKeyring = true;
    security.polkit.enable = true;
    environment.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_WAYLAND_FORCE_DPI = "physical";
    };
  };
}
