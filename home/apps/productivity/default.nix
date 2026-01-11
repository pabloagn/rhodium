{ pkgs, ... }:
{
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

    # --- Task Management ---
    taskwarrior3 # Comprehensive task management CLI
    taskwarrior-tui # TUI for taskwarrior

    # --- Timers ---
    uair
    pom
    openpomodoro-cli
    yad # GUI dialogue for shell scripts
  ];
}
