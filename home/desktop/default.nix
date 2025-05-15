{ ... }:

{
  imports = [
    # Import component configurations.
    # Each of these files (hyprland.nix, rofi.nix, waybar.nix)
    # will define its OWN options (e.g., options.rhodium.desktop.wm.hyprland.enable)
    # and its OWN config block (e.g., config = mkIf config.rhodium.desktop.wm.hyprland.enable { ... }; )

    ./wm/hyprland.nix      # This will define options.rhodium.desktop.wm.hyprland...
    ./launcher/rofi.nix    # This will define options.rhodium.desktop.launcher.rofi...
    ./bar/waybar.nix       # This will define options.rhodium.desktop.bar.waybar...
    # ./notifications/dunst.nix # If you have a dunst module, it defines its options
  ];

  # NO options defined here for sub-components.
  # NO config block here that depends on a general "desktop enable" flag unless
  # you have settings that TRULY apply to ALL possible desktop configurations
  # imported above, and you want a master switch for them.
  # For now, let's keep it simple: this file only imports.
}
