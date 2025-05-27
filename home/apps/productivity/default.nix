{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Calculators
    qalculate-gtk

    # Calendars
    # kdePackages.korganizer
    # evolution
    calcurse # CLI calendar
  ];
}

