{
  inputs,
  config,
  ...
}:
let
  zenProfileSettings = {
    # Core functionality
    "browser.shell.checkDefaultBrowser" = false;
    "browser.shell.didSkipDefaultBrowserCheckOnFirstRun" = true;
    "browser.aboutConfig.showWarning" = false;
    "browser.tabs.warnOnOpen" = false;

    # Privacy settings
    "dom.security.https_only_mode" = true;
    "dom.security.https_only_mode_ever_enabled" = true;
    "privacy.donottrackheader.enabled" = true;
    "privacy.globalprivacycontrol.was_ever_enabled" = true;
    "network.dns.disablePrefetch" = true;
    "network.http.speculative-parallel-limit" = 0;
    "network.predictor.enabled" = false;
    "network.prefetch-next" = false;

    # Telemetry/tracking disable
    "app.shield.optoutstudies.enabled" = false;
    "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = 2;
    "toolkit.telemetry.reportingpolicy.firstRun" = false;

    # UI/UX preferences
    "general.smoothScroll" = false;
    "mousewheel.default.delta_multiplier_y" = 50;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

    # Zen specific
    "zen.welcome-screen.seen" = true;
    "zen.themes.updated-value-observer" = true;

    # Download settings
    "browser.download.lastDir" = "${config.home.homeDirectory}/downloads";
  };
in
{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser = {
    # TODO: Causing build problems due to native messaging host folder
    enable = true;
    profiles = {
      personal = {
        name = "Personal";
        isDefault = true;
        settings = zenProfileSettings;
        # TODO: Empty userChrome for now
        userChrome = "";
        # TODO: Empty extensions list for now
        extensions = [ ];
      };
    };

    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
    };
  };
}
