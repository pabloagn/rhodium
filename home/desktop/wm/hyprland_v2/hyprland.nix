{ pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    # General
    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
      "HYPRCURSOR_THEME,rose-pine-hyprcursor"
    ];
    monitor = "eDP-1,2880x1620@120,0x0,1.5";
    exec-once = "bash ~/.local/bin/desktop-autostart.sh";
    general {
        gaps_in = 10
        gaps_out = 15
        border_size = 0
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)
        resize_on_border = false
        allow_tearing = false
        layout = "dwindle"
    };
  };

  xdg.configFile."hypr/hyprland.conf" = {
    source = ./hyprland.conf;
  };

  # Module configurations
  xdg.configFile."hypr/modules/monitors.conf" = {
    source = ./modules/monitors.conf;
  };

  xdg.configFile."hypr/modules/keybinds.conf" = {
    source = ./modules/keybinds.conf;
  };

  xdg.configFile."hypr/modules/workspaces.conf" = {
    source = ./modules/workspaces.conf;
  };

  xdg.configFile."hypr/modules/window-rules.conf" = {
    source = ./modules/window-rules.conf;
  };

  xdg.configFile."hypr/modules/keyboard.conf" = {
    source = ./modules/keyboard.conf;
  };
}
