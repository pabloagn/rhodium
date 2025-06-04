{ config, userPreferences, ... }:

let
  homeDir = config.home.homeDirectory;

  dirs = {
    rhodium = "${homeDir}/rhodium";
    documents = "${homeDir}/documents";
    downloads = "${homeDir}/downloads";
    projects = "${homeDir}/projects";
    academic = "${homeDir}/academic";
    solenoidLabs = "${homeDir}/solenoid-labs";
    professional = "${homeDir}/professional";
    vaults = "${homeDir}/vaults";
  };

  derivedDirs = {
    vaultsSanctum = "${dirs.vaults}/sanctum";
    vaultsFiction = "${dirs.vaults}/fiction";
  };

  xdgDirs = {
    binHome = "${homeDir}/.local/bin";
    configHome = "${homeDir}/.config";
    cacheHome = "${homeDir}/.cache";
    shareApps = "${homeDir}/.nix-profile/share/applications";
  };
in
{
  home.sessionVariables = {

    # App Preferences
    BROWSER = userPreferences.apps.browser;
    EDITOR = userPreferences.apps.editor;
    VISUAL = userPreferences.apps.editor;
    SUDO_EDITOR = userPreferences.apps.editor;
    TERMINAL = userPreferences.apps.terminal;
    IMAGE_VIEWER = userPreferences.apps.imageViewer;
    VIDEO_PLAYER = userPreferences.apps.videoPlayer;
    AUDIO_PLAYER = userPreferences.apps.audioPlayer;
    PDF_VIEWER = userPreferences.apps.pdfViewer;
    WM = userPreferences.apps.wm;
    PAGER = userPreferences.apps.pager;
    MANPAGER = userPreferences.apps.pager;

    # Main dirs
    RHODIUM = dirs.rhodium;
    HOME_DOWNLOADS = dirs.downloads;
    HOME_PROJECTS = dirs.projects;
    HOME_ACADEMIC = dirs.academic;
    HOME_SOLENOIDLABS = dirs.solenoidLabs;
    HOME_PROFESSIONAL = dirs.professional;
    HOME_VAULTS = dirs.vaults;

    # Derived dirs
    HOME_VAULTS_SANCTUM = derivedDirs.vaultsSanctum;
    HOME_VAULTS_FICTION = derivedDirs.vaultsFiction;

    # Device mounts (TODO: Configure)
    MNT_A = "";
    MNT_B = "";
    MNT_C = "";

    # XDG Base Directory Specification
    XDG_BIN_HOME = xdgDirs.binHome;
    XDG_CONFIG_HOME = xdgDirs.configHome;
    XDG_CACHE_HOME = xdgDirs.cacheHome;
    XDG_SHARE_APPS = xdgDirs.shareApps;

    # App-specific
    HISTFILE = "${config.xdg.cacheHome}/zsh/.zsh_history";
    NODE_REPL_HISTORY = "${config.xdg.cacheHome}/node/.node_repl_history";
    PYTHON_HISTORY = "${config.xdg.cacheHome}/python/.python_history";
    LESSHISTFILE = "/dev/null";
    KEYTIMEOUT = "1";
  };

  home.sessionPath = [
    xdgDirs.binHome
  ];

  # Set xdg custom dirs for userDirs
  xdg.userDirs = {
    enable = true;
    createDirectories = false;

    publicShare = null;
    templates = null;
    desktop = null;
    documents = null;
    download = dirs.downloads;
    music = null;
    videos = null;
    pictures = null;
  };
}
