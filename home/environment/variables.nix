# home/environment/variables.nix

{ lib, config, pkgs, _haumea, rhodiumLib, ... }:

with lib;
let
  moduleCfg = getAttrFromPath _haumea.configPath config;
  preferredApps = config.rhodium.home.environment.preferredApps;
  homeDir = config.home.homeDirectory;

  xdgSessionVars = rhodiumLib.mkXdgSessionVariables homeDir;
  rhodiumSessionVars = rhodiumLib.mkRhodiumSessionVariables homeDir;

  mkPreferredAppAssertion = (prefKeyName: defaultAppName: appTypeDesc:
    let
      chosenAppName = preferredApps.${prefKeyName} or defaultAppName;
    in
    {
      assertion = pkgs ? ${chosenAppName};
      message = ''
        Rhodium Configuration Error: Your preferred ${appTypeDesc} ('${chosenAppName}')
        specified via 'rhodium.home.environment.preferredApps.${prefKeyName}'
        is not a known package attribute (i.e., pkgs.${chosenAppName} does not exist).

        This will cause a build failure. To resolve this, please ensure:
        1. The application name ('${chosenAppName}') is spelled correctly in your profile.
        2. The corresponding Rhodium module for this application is enabled in your profile,
           which should make the package available (e.g., through home.packages or programs.<name>.package).
           Example: rhodium.home.apps.terminal.emulators.${chosenAppName}.enable = true;
        3. If it's a custom package not managed by a Rhodium module, ensure it's correctly
           added to your 'pkgs' set via overlays.
      '';
    });

in
{
  options = setAttrByPath _haumea.configPath {
    enable = mkEnableOption "${rhodiumLib.metadata.appName}'s environment variables";
  };

  config = mkIf moduleCfg.enable {
    assertions = [
      (mkPreferredAppAssertion "browser" "firefox" "Web Browser")
      (mkPreferredAppAssertion "editor" "hx" "Text Editor")
      (mkPreferredAppAssertion "terminal" "ghostty" "Terminal Emulator")
      (mkPreferredAppAssertion "imageViewer" "feh" "Image Viewer")
      (mkPreferredAppAssertion "videoPlayer" "mpv" "Video Player")
      (mkPreferredAppAssertion "audioPlayer" "clementine" "Audio Player")
      (mkPreferredAppAssertion "pdfViewer" "zathura" "PDF Viewer")
      (mkPreferredAppAssertion "wm" "hyprland" "Window Manager")
    ];

    home.sessionVariables = xdgSessionVars // rhodiumSessionVars // {
      # Application variables
      BROWSER = preferredApps.browser or "firefox";
      EDITOR = preferredApps.editor or "hx";
      VISUAL = preferredApps.editor or "hx";
      SUDO_EDITOR = preferredApps.editor or "hx";
      TERMINAL = preferredApps.terminal or "ghostty";
      IMAGE_VIEWER = preferredApps.imageViewer or "feh";
      VIDEO_PLAYER = preferredApps.videoPlayer or "mpv";
      AUDIO_PLAYER = preferredApps.audioPlayer or "clementine";
      PDF_VIEWER = preferredApps.pdfViewer or "zathura";
      WM = preferredApps.wm or "hyprland";

      # Application-specific variables
      HISTFILE = "${xdgSessionVars.XDG_CACHE_HOME}/zsh/.zsh_history";
      NODE_REPL_HISTORY = "${xdgSessionVars.XDG_CACHE_HOME}/node/.node_repl_history";
      PYTHON_HISTORY = "${xdgSessionVars.XDG_CACHE_HOME}/python/.python_history";
      LESSHISTFILE = "/dev/null";
      KEYTIMEOUT = 1;
    };
  };
}
