{
  lib,
  config,
  pkgs,
  host,
  ...
}:
with lib;
let
  cfg = config.scripts;

  # Path to traverse
  scriptsSourcePath = ../scripts;

  # Folders to include
  validFolders = [
    "common"
    "docker"
    "fuzzel"
    "launchers"
    "rdp"
    "rofi"
    "testing"
    "utils"
  ];

  # Get the directory
  scriptFiles = builtins.readDir scriptsSourcePath;

  # Validate
  isValidFolder =
    name:
    let
      fileType = scriptsDir.${name};
      isDirectory = fileType == "directory";
      isValidName = builtins.elem name validFolders;
    in
    isDirectory && isValidName;

  # Get list of actual script files
  scriptNames = lib.filter isScript (builtins.attrNames scriptFiles);

  # Create symlinks for static scripts
  mkStaticScriptLink = scriptName: {
    "${config.home.sessionVariables.XDG_BIN_HOME}/${scriptName}" = {
      source = config.lib.file.mkOutOfStoreSymlink "${scriptsSourcePath}/${scriptName}";
      executable = true;
    };
  };

  # Generate static script symlinks
  staticScriptLinks = lib.foldl' (acc: name: acc // (mkStaticScriptLink name)) { } scriptNames;

  # Host-specific monitor configuration
  inherit (host.mainMonitor)
    monitorID
    monitorResolution
    monitorRefreshRate
    monitorScalingFactor
    ;

  # NOTE: Only used for hyprland
  # Nix-generated scripts
  desktopAutostart = pkgs.writeShellScript "desktop-autostart" ''
    #!${pkgs.runtimeShell}
    # Wallpaper
    ${pkgs.hyprpaper}/bin/hyprpaper &
    # Network manager applet
    ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &
    # Bluetooth applet
    ${pkgs.blueman}/bin/blueman-applet &
    # Status bar
    ${pkgs.waybar}/bin/waybar &
    # Add some delay and error handling
    sleep 1
    echo "Desktop autostart completed" > /tmp/autostart.log
  '';

  # Rofi monitor switching script
  rofiMonitors = pkgs.writeShellScript "rofi-monitors" ''
    #!${pkgs.runtimeShell}

    ROFI_THEME="$HOME/.config/rofi/themes/chiaroscuro.rasi"

    # Host monitor configuration
    MAIN_MONITOR="${monitorID}"
    MAIN_RESOLUTION="${if monitorResolution != "" then monitorResolution else "preferred"}"
    MAIN_REFRESH="${if monitorRefreshRate != "" then "@${monitorRefreshRate}" else ""}"
    MAIN_SCALE="${if monitorScalingFactor != "" then monitorScalingFactor else "1.0"}"

    # Common external monitor
    EXTERNAL_MONITOR="HDMI-A-1"
    EXTERNAL_CONFIG="3840x2160@60,0x0,1.5"

    # Monitor configurations
    declare -A monitor_configs=(
        ["Main Only"]="$MAIN_MONITOR,''${MAIN_RESOLUTION}''${MAIN_REFRESH},0x0,$MAIN_SCALE"
        ["External Only"]="$EXTERNAL_MONITOR,$EXTERNAL_CONFIG"
        ["Dual (Main + External)"]="$MAIN_MONITOR,''${MAIN_RESOLUTION}''${MAIN_REFRESH},0x0,$MAIN_SCALE and $EXTERNAL_MONITOR,$EXTERNAL_CONFIG"
        ["Mirror"]="$MAIN_MONITOR,''${MAIN_RESOLUTION}''${MAIN_REFRESH},0x0,$MAIN_SCALE and $EXTERNAL_MONITOR,''${MAIN_RESOLUTION}''${MAIN_REFRESH},0x0,$MAIN_SCALE"
    )

    # Show rofi menu
    choice=$(printf '%s\n' "''${!monitor_configs[@]}" | ${pkgs.rofi}/bin/rofi -dmenu -i -P "λ " -theme "$ROFI_THEME" -markup-rows)

    if [[ -n "$choice" && -n "''${monitor_configs[$choice]}" ]]; then
        # Apply the monitor configuration
        if [[ "''${monitor_configs[$choice]}" == *" and "* ]]; then
            # Multiple monitors
            IFS=' and ' read -ra MONITORS <<< "''${monitor_configs[$choice]}"
            for monitor in "''${MONITORS[@]}"; do
                ${pkgs.hyprland}/bin/hyprctl keyword monitor "$monitor"
            done
        else
            # Single monitor
            ${pkgs.hyprland}/bin/hyprctl keyword monitor "''${monitor_configs[$choice]}"
            # Disable other monitors
            if [[ "$choice" == "Main Only" ]]; then
                ${pkgs.hyprland}/bin/hyprctl keyword monitor "$EXTERNAL_MONITOR,disable"
            elif [[ "$choice" == "External Only" ]]; then
                ${pkgs.hyprland}/bin/hyprctl keyword monitor "$MAIN_MONITOR,disable"
            fi
        fi

        # Restart hyprpaper to apply wallpapers to new monitor setup
        ${pkgs.procps}/bin/pkill hyprpaper
        sleep 0.5
        ${pkgs.hyprpaper}/bin/hyprpaper &

        # Send notification
        ${pkgs.libnotify}/bin/notify-send "Monitor Setup" "Applied: $choice"
    fi
  '';
  # TODO: eventually move this to a scripts module for hyprland and make it dynamic
  # Nix-generated script links
  # nixScriptLinks = {
  #   "${config.home.sessionVariables.XDG_BIN_HOME}/desktop-autostart.sh" = {
  #     source = desktopAutostart;
  #     executable = true;
  #   };
  #   "${config.home.sessionVariables.XDG_BIN_HOME}/rofi-monitors.sh" = {
  #     source = rofiMonitors;
  #     executable = true;
  #   };
  # };

  # Combine both types of scripts
  # allScriptLinks = staticScriptLinks // nixScriptLinks;
  allScriptLinks = staticScriptLinks;
in
{
  options.scripts = {
    enable = mkEnableOption "Link individual scripts to local bin path with executable permissions";
  };

  config = mkIf cfg.enable {
    home.file = allScriptLinks;

    # Ensure bin directory exists
    home.activation.create-script-dirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "${config.home.sessionVariables.XDG_BIN_HOME}"
    '';
  };
}
