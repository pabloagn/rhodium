{
  config,
  userPreferences,
  ...
}:
let
  homeDir = config.home.homeDirectory;

  dirs = {
    academic = "${homeDir}/academic";
    dev = "${homeDir}/dev";
    downloads = "${homeDir}/downloads";
    pendings = "${homeDir}/pendings";
    professional = "${homeDir}/professional";
    solenoidLabs = "${homeDir}/solenoid-labs";
    vaults = "${homeDir}/vaults";
  };

  xdgDirs = {
    binHome = "${homeDir}/.local/bin";
    configHome = "${homeDir}/.config";
    cacheHome = "${homeDir}/.cache";
    shareApps = "${homeDir}/.nix-profile/share/applications";
  };

  derivedDirs = {
    # Dev
    devPhantom = "${dirs.dev}/phantom";
    devRhodium = "${dirs.dev}/rhodium";
    devAlloys = "${dirs.dev}/alloys.rhf";
    devChiaroscuro = "${dirs.dev}/chiaroscuro.rht";
    devUtils = "${dirs.dev}/utils";

    # Obsidian Vault
    vaultsSanctum = "${dirs.vaults}/sanctum";
    vaultsFiction = "${dirs.vaults}/fiction";

    # User binaries
    userBinFuzzel = "${xdgDirs.binHome}/fuzzel";
    userBinCommon = "${xdgDirs.binHome}/common";
    userBinDocker = "${xdgDirs.binHome}/docker";
    userBinLaunchers = "${xdgDirs.binHome}/launchers";
    userBinRdp = "${xdgDirs.binHome}/rdp";
    userBinRofi = "${xdgDirs.binHome}/rofi";
    userBinUtils = "${xdgDirs.binHome}/utils";
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
    HOME_ACADEMIC = dirs.academic;
    HOME_DOWNLOADS = dirs.downloads;
    HOME_SOLENOIDLABS = dirs.solenoidLabs;
    HOME_PROFESSIONAL = dirs.professional;
    HOME_VAULTS = dirs.vaults;

    # Dev
    DEV_PHANTOM = derivedDirs.devPhantom;
    DEV_UTILS = derivedDirs.devUtils;
    RHODIUM = derivedDirs.devRhodium;
    DEV_ALLOYS = derivedDirs.devAlloys;
    DEV_CHIAROSCURO = derivedDirs.devChiaroscuro;

    # Vaults
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

    # User binaries
    USERBIN_FUZZEL = derivedDirs.userBinFuzzel;
    USERBIN_COMMON = derivedDirs.userBinCommon;
    USERBIN_DOCKER = derivedDirs.userBinDocker;
    USERBIN_LAUNCHERS = derivedDirs.userBinLaunchers;
    USERBIN_RDP = derivedDirs.userBinRdp;
    USERBIN_ROFI = derivedDirs.userBinRofi;
    USERBIN_UTILS = derivedDirs.userBinUtils;

    # App-specific
    HISTFILE = "${config.xdg.cacheHome}/zsh/.zsh_history";
    NODE_REPL_HISTORY = "${config.xdg.cacheHome}/node/.node_repl_history";
    PYTHON_HISTORY = "${config.xdg.cacheHome}/python/.python_history";
    LESSHISTFILE = "/dev/null";
    KEYTIMEOUT = "1";
    MOZ_ENABLE_WAYLAND = "1";

    # Special Dotconfigs
    # NOTE:
    # - Here we include dotconfigs
    #   that are not managed declaratively through NixOS
    # - A good example is Doom Emacs
    DOOMDIR = "${xdgDirs.configHome}/doom";
  };

  # Add directories to user's PATH
  home.sessionPath = [
    xdgDirs.binHome
    "${homeDir}/.config/emacs/bin"
  ];

  # Set xdg custom dirs for userDirs
  xdg = {
    enable = true;
    userDirs = {
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
  };
}
