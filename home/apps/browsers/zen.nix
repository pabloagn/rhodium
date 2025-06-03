{ inputs, config, ... }:
let
  zenProfileSettings = {
    "accessibility.typeaheadfind.flashBar" = 0;
    "app.normandy.first_run" = false;
    "app.normandy.migrationsApplied" = 12;
    "app.shield.optoutstudies.enabled" = false;
    "browser.aboutConfig.showWarning" = false;
    "browser.bookmarks.addedImportButton" = true;
    "browser.bookmarks.restore_default_bookmarks" = false;
    "browser.contentblocking.category" = "standard";
    "browser.download.lastDir" = "${config.home.homeDirectory}/Downloads";
    "browser.download.viewableInternally.typeWasRegistered.avif" = true;
    "browser.download.viewableInternally.typeWasRegistered.jxl" = true;
    "browser.download.viewableInternally.typeWasRegistered.webp" = true;
    "browser.laterrun.enabled" = true;
    "browser.newtabpage.storageVersion" = 1;
    "browser.pageActions.persistedActions" = "{\"ids\":[\"bookmark\"],\"idsInUrlbar\":[\"bookmark\"],\"idsInUrlbarPreProton\":[],\"version\":1}";
    "browser.pagethumbnails.storage_version" = 3;
    "browser.policies.applied" = true;
    "browser.proton.toolbar.version" = 3;
    "browser.search.region" = "GB";
    "browser.search.serpEventTelemetryCategorization.regionEnabled" = false;
    "browser.shell.checkDefaultBrowser" = false;
    "browser.shell.defaultBrowserCheckCount" = 1;
    "browser.shell.didSkipDefaultBrowserCheckOnFirstRun" = true;
    "browser.tabs.warnOnOpen" = false;
    "browser.uiCustomization.state" = "{\"placements\":{\"widget-overflow-fixed-list\":[],\"unified-extensions-area\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"customizableui-special-spring1\",\"vertical-spacer\",\"urlbar-container\",\"customizableui-special-spring2\",\"unified-extensions-button\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\"],\"vertical-tabs\":[],\"PersonalToolbar\":[\"import-button\",\"personal-bookmarks\"],\"zen-sidebar-top-buttons\":[],\"zen-sidebar-bottom-buttons\":[\"preferences-button\",\"zen-workspaces-button\",\"downloads-button\"]},\"seen\":[\"developer-button\"],\"dirtyAreaCache\":[\"nav-bar\",\"vertical-tabs\",\"zen-sidebar-bottom-buttons\",\"PersonalToolbar\",\"toolbar-menubar\",\"TabsToolbar\"],\"currentVersion\":22,\"newElementCount\":2}";
    "browser.urlbar.placeholderName" = "Google";
    "browser.urlbar.quicksuggest.migrationVersion" = 2;
    "datareporting.policy.dataSubmissionPolicyAcceptedVersion" = 2;
    "doh-rollout.doneFirstRun" = true;
    "doh-rollout.home-region" = "GB";
    "dom.forms.autocomplete.formautofill" = true;
    "dom.security.https_only_mode" = true;
    "dom.security.https_only_mode_ever_enabled" = true;
    "extensions.activeThemeID" = "";
    "extensions.blocklist.pingCountVersion" = 0;
    "extensions.colorway-builtin-themes-cleanup" = 1;
    "extensions.pendingOperations" = false;
    "extensions.pictureinpicture.enable_picture_in_picture_overrides" = true;
    "extensions.quarantinedDomains.list" = "autoatendimento.bb.com.br,ibpf.sicredi.com.br,ibpj.sicredi.com.br,internetbanking.caixa.gov.br,www.ib12.bradesco.com.br,www2.bancobrasil.com.br";
    "extensions.signatureCheckpoint" = 1;
    "extensions.systemAddonSet" = "{\"schema\":1,\"addons\":{}}";
    "extensions.webcompat.enable_shims" = true;
    "extensions.webcompat.perform_injections" = true;
    "gecko.handlerService.defaultHandlersVersion" = 1;
    "general.smoothScroll" = false;
    "mousewheel.default.delta_multiplier_y" = 50;
    "network.dns.disablePrefetch" = true;
    "network.http.speculative-parallel-limit" = 0;
    "network.predictor.enabled" = false;
    "network.prefetch-next" = false;
    "nimbus.migrations.latest" = 0;
    "pdfjs.enabledCache.state" = true;
    "pdfjs.migrationVersion" = 2;
    "privacy.bounceTrackingProtection.hasMigratedUserActivationData" = true;
    "privacy.clearOnShutdown_v2.formdata" = true;
    "privacy.donottrackheader.enabled" = true;
    "privacy.globalprivacycontrol.was_ever_enabled" = true;
    "privacy.sanitize.clearOnShutdown.hasMigratedToNewPrefs3" = true;
    "privacy.sanitize.pending" = "[]";
    "sidebar.backupState" = "{\"panelOpen\":false,\"launcherExpanded\":false,\"launcherVisible\":false}";
    "sidebar.visibility" = "hide-sidebar";
    "toolkit.telemetry.reportingpolicy.firstRun" = false;
    "zen.keyboard.shortcuts.version" = 9;
    "zen.migration.version" = 4;
    "zen.themes.updated-value-observer" = true;
    "zen.welcome-screen.seen" = true;
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Essential for userChrome/Content
  };
in
{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser = {
    enable = true;
    profiles = {
      personal = {
        name = "Personal";
        isDefault = true;
        settings = zenProfileSettings;
        userChrome = ''

        '';
        extensions = [

        ];
      };
    };

    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
    };
  };
}
