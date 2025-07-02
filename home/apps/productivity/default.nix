{pkgs, ...}: {
  home.packages = with pkgs; [
    # --- Calculators ---
    libqalculate # CLI Calculator
    qalculate-gtk # GUI Calculator
    element # CLI Periodic Table

    # --- Calendars ---
    # kdePackages.korganizer
    # evolution
    # calcurse # CLI calendar
    calcure # Modern calcurse alternative
    # ulauncher # GUI-based launcher
  ];
}
