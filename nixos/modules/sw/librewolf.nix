{
  config,
  lib,
  pkgs-unstable,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;
    package = pkgs-unstable.librewolf;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      ExtensionSettings = {
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        # BitWarden - FIXME
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
      };
      FirefoxHome = {
        "Search" = false;
      };
      HardwareAcceleration = true;
      Preferences = {
        "browser.preferences.defaultPerformanceSettings.enabled" = false;
        "browser.startup.homepage" = "about:home";
        "browser.toolbar.bookmarks.visibility" = "newtab";
        "browser.toolbars.bookmarks.visibility" = "newtab";
        "browser.warnOnQuit" = false;
        "browser.warnOnQuitShortcut" = false;
        "places.history.enabled" = "false";
        "privacy.resistFingerprinting" = true;
        "privacy.resistFingerprinting.autoDeclineNoUserInputCanvasPrompts" = true;
      };
    };
  };
}
