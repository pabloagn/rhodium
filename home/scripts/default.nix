{ config, pkgs, ... }:

let
  desktopAutostart = pkgs.writeShellScript "desktop-autostart" ''
    #!${pkgs.runtimeShell}

    # Wallpaper
    hyprpaper &

    # Autostart network manager
    nm-applet --indicator &

    # Execute bluetooth utils
    blueman-applet &

    # Wallpaper & menu bar
    waybar &
  '';
in
{
  /*
    NOTE:
    Even though it's convention to ommit the .sh extension
    under XDG_BIN_HOME, it brings clarity
  */
  home.file."${config.home.sessionVariables.XDG_BIN_HOME}/desktop-autostart.sh" = {
    source = desktopAutostart;
    executable = true;
  };
}
