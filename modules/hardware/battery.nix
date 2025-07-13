{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    acpi # Battery/temperature info
  ];
  services.upower = {
    enable = true; # Abstraction for enumerating power devices
  };
}
