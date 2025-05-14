# hosts/common/default.nix

{ config, pkgs, lib, ... }:

{
  # Timezone, locale, basic networking that's truly common
  # TODO: This is not as common.
  # We need to be able to customize this, particularly locales and keyboards.
  time.timeZone = "Etc/UTC";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
}
