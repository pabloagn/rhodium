{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.scripts;

  # Static scripts from home/scripts/ directory
  scriptsSourcePath = ../scripts;
  scriptFiles = builtins.readDir scriptsSourcePath;

  # Filter out non-script files (like default.nix)
  isScript = name:
    let
      fileType = scriptFiles.${name};
      isRegularFile = fileType == "regular";
      isNotNix = !lib.hasSuffix ".nix" name;
    in
    isRegularFile && isNotNix;

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
  staticScriptLinks = lib.foldl' (acc: name: acc // (mkStaticScriptLink name)) {} scriptNames;

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

    # Optional: Add some delay and error handling
    sleep 1
    echo "Desktop autostart completed" > /tmp/autostart.log
  '';

  # Nix-generated script links
  nixScriptLinks = {
    "${config.home.sessionVariables.XDG_BIN_HOME}/desktop-autostart.sh" = {
      source = desktopAutostart;
      executable = true;
    };

    # Add more Nix-generated scripts here as needed
    # "${config.home.sessionVariables.XDG_BIN_HOME}/another-script.sh" = {
    #   source = pkgs.writeShellScript "another-script" ''
    #     #!${pkgs.runtimeShell}
    #     echo "Another script"
    #   '';
    #   executable = true;
    # };
  };

  # Combine both types of scripts
  allScriptLinks = staticScriptLinks // nixScriptLinks;
in
{
  options.scripts = {
    enable = mkEnableOption "Link individual scripts to local bin path with executable permissions";
  };

  config = mkIf cfg.enable {
    home.file = allScriptLinks;

    # Ensure bin directory exists
    home.activation.create-script-dirs = lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p "${config.home.sessionVariables.XDG_BIN_HOME}"
    '';
  };
}
