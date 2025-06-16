{pkgs, ...}: {
  home.packages = with pkgs; [
    qalculate-gtk # Calculator

    # Calendars
    # kdePackages.korganizer
    # evolution
    calcurse # CLI calendar
    ulauncher # GUI-based launcher
  ];
}
