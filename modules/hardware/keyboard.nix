{pkgs, ...}:
# TODO: Dynamic
{
  environment.systemPackages = with pkgs; [
    xorg.xev # xorg key registry
  ];

  time.timeZone = "Europe/London"; # Time zone
  i18n.defaultLocale = "en_GB.UTF-8"; # Locale

  # Additional properties
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  console.keyMap = "uk"; # Default console Keymap

  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # NOTE: Required for kmonad
  hardware.uinput = {
    enable = true;
  };
}
