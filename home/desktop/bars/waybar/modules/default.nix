{ lib, ... }:
let
  # --- Import all modules ---
  moduleBacklight = import ./backlight.nix;
  moduleBattery = import ./battery.nix;
  moduleBluetooth = import ./bluetooth.nix;
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
  moduleTray = import ./tray.nix;


  # --- Import Groups ---
  moduleGroupThermals = import ./group-thermals.nix;
  moduleGroupWifiSpeed = import ./group-wifi-speed.nix;

  # --- Import Separators And Formatters ---
  moduleCustomSeparator = import ./custom-separator.nix;
  moduleCustomBullet = import ./custom-bullet.nix;

  # --- List of active modules ---
  usedModules = [
    moduleBattery
    # TODO:
    moduleBacklight
    moduleBluetooth
    moduleCustomVpn
    moduleCpu
    moduleDisk
    moduleMemory
    moduleWireplumberSink
    moduleWireplumberSource
    moduleCustomBullet
    moduleCustomClock
    moduleCustomSeparator
    moduleCustomThmAmb
    moduleCustomThmAmd
    moduleCustomThmBati
    moduleCustomThmBatv
    moduleCustomThmCpu
    moduleCustomThmFan
    moduleCustomThmNvme
    moduleCustomThmPwr
    moduleGroupThermals
    moduleGroupWifiSpeed
    moduleKeyboardStateCapslock
    moduleNetworkWifiDl
    moduleNetworkWifiUl
    moduleNiriLanguage
    moduleNiriWorkspaces
    moduleTray
  ];

  # --- Merge module-provided Waybar configuration ---
  waybarModules = lib.foldl lib.recursiveUpdate { } (map (m: m.waybarModules or { }) usedModules);

  # --- Merge module-provided extras ---
  extraOptions = lib.foldl lib.recursiveUpdate { } (map (m: m.extraOptions or { }) usedModules);

  # --- Base bar configuration ---
  baseConfig = {
    # General
    exclusive = true;
    fixed-center = true;
    height = 35;
    ipc = true;
    layer = "top";
    margin-bottom = 0;
    margin-left = 12;
    margin-right = 12;
    margin-top = 10;
    mode = "indivisible";
    name = "mainJustine";
    position = "top";
    reload_style_on_change = true;
    spacing = 1;

    # Modules
    modules-left = [
      "niri/workspaces"
    ];
    modules-center = [
      "custom/clock"
    ];
    modules-right = [
      "group/wifi-speed"
      "custom/vpn"
      "custom/separator"
      "group/thermals"
      "battery"
      "cpu"
      "memory"
      "disk"
      "custom/separator"
      "backlight"
      "wireplumber#sink"
      "custom/separator"
      "niri/language"
      "custom/separator"
      "tray"

      # "keyboard-state#capslock"
    ];
  };
in
{
  config = {
    inherit (extraOptions) xdg;

    programs.waybar.settings.mainBar = lib.recursiveUpdate baseConfig waybarModules;
  };
}
