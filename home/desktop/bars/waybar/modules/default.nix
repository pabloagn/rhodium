{lib, ...}: let
  # --- Import Modules ---
  moduleBacklight = import ./backlight.nix;
  moduleBattery = import ./battery.nix;
  moduleBluetooth = import ./bluetooth.nix;
  moduleClock = import ./clock.nix;
  moduleCpu = import ./cpu.nix;
  moduleCustomClock = import ./custom-clock.nix;
  moduleCustomRhodium = import ./custom-rhodium.nix;
  moduleCustomThmAmb = import ./custom-thm-amb.nix;
  moduleCustomThmAmd = import ./custom-thm-amd.nix;
  moduleCustomThmBati = import ./custom-thm-bati.nix;
  moduleCustomThmBatv = import ./custom-thm-batv.nix;
  moduleCustomThmCpu = import ./custom-thm-cpu.nix;
  moduleCustomThmFan = import ./custom-thm-fan.nix;
  moduleCustomThmNvme = import ./custom-thm-nvme.nix;
  moduleCustomThmPwr = import ./custom-thm-pwr.nix;
  moduleCustomVpn = import ./custom-vpn.nix;
  moduleDisk = import ./disk.nix;
  moduleKeyboardStateCapslock = import ./keyboard-state-capslock.nix;
  moduleKeyboardStateNumlock = import ./keyboard-state-numlock.nix;
  moduleMemory = import ./memory.nix;
  moduleNetworkWifiDl = import ./network-wifi-dl.nix;
  moduleNetworkWifiUl = import ./network-wifi-ul.nix;
  moduleNiriLanguage = import ./niri-language.nix;
  moduleNiriWorkspaces = import ./niri-workspaces.nix;
  moduleWireplumberSink = import ./wireplumber-sink.nix;
  moduleWireplumberSource = import ./wireplumber-source.nix;

  # --- Import Groups ---
  moduleGroupThermals = import ./group-thermals.nix;
  moduleGroupWifiSpeed = import ./group-wifi-speed.nix;

  # --- Import Separators And Formatters ---
  moduleCustomSeparator = import ./custom-separator.nix;
  moduleCustomBullet = import ./custom-bullet.nix;

  # --- Collect All Modules Used In This Bar ---
  usedModules = [
    moduleCustomClock
    moduleBattery
    moduleNiriLanguage
    moduleKeyboardStateCapslock
    moduleNiriWorkspaces
    moduleGroupWifiSpeed
    moduleGroupThermals
    moduleCustomSeparator
  ];
in {
  # --- Waybar Configuration ---
  programs.waybar.settings.mainBar =
    lib.mkMerge
    (
      map (m: m.waybarModules) usedModules
    )
    // {
      # Explicit module order
      modules-left = ["niri/workspaces"];
      modules-center = ["custom/clock"];
      modules-right = [
        "group/wifi-speed"
        "group/thermals"
        "battery"
        "custom/separator"
        "niri/language"
        "keyboard-state#capslock"
      ];
    };

  # --- Merge All Extras (assets, files, etc) ---
  config = lib.mkMerge (
    map (m: m.extraOptions or {}) usedModules
  );
}
