{
  config,
  pkgs,
  lib,
  ...
}:

{
  systemd.services.kmonad-keychron = {
    description = "KMonad for Keychron keyboard";

    # Start once multi‑user is up
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];

    # Extra binaries added to this unit’s PATH
    path = with pkgs; [
      bashInteractive # NOTE: Makes /usr/bin/env bash resolve
      coreutils
      findutils
      gnugrep
      gnused
      fuzzel
      jq
      wl-clipboard
    ];

    # Variables your shell scripts expect
    environment = {
      LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
      TZDIR = "${pkgs.tzdata}/share/zoneinfo";
      XDG_BIN_HOME = "%h/.local/bin"; # %h expands to /home/pabloagn
    };

    serviceConfig = {
      Type = "simple";
      User = "pabloagn"; # run as your user
      Nice = "-5";
      Restart = "no";

      # Wait until the keyboard appears
      ExecStartPre = "${pkgs.bash}/bin/bash -c 'until [ -e /dev/input/by-id/usb-Keychron_Keychron_V1-event-kbd ]; do sleep 0.5; done'";

      # Launch KMonad with your layout
      ExecStart = ''
        ${pkgs.kmonad}/bin/kmonad /home/pabloagn/.config/kmonad/keychron.kbd
      '';
    };
  };
}

# { pkgs, ... }:
# {
#   # In your system configuration (not home-manager)
#   systemd.services.kmonad-keychron = {
#     description = "KMonad for Keychron keyboard";
#     after = [ "multi-user.target" ];
#     serviceConfig = {
#       Type = "simple";
#       User = "pabloagn"; # Your username
#       ExecStartPre = "${pkgs.bash}/bin/bash -c 'until [ -e /dev/input/by-id/usb-Keychron_Keychron_V1-event-kbd ]; do sleep 0.5; done'";
#       ExecStart = "${pkgs.kmonad}/bin/kmonad /home/pabloagn/.config/kmonad/keychron.kbd";
#       Restart = "no";
#       Nice = -5;
#     };
#   };
#
#   # Update your udev rule to use system service
#   services.udev.extraRules = ''
#     ACTION=="add", SUBSYSTEM=="input", KERNEL=="event*", \
#       ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0311", \
#       TAG+="systemd", ENV{SYSTEMD_WANTS}="kmonad-keychron.service"
#
#     ACTION=="remove", SUBSYSTEM=="input", KERNEL=="event*", \
#       ENV{ID_VENDOR_ID}=="3434", ENV{ID_MODEL_ID}=="0311", \
#       RUN+="${pkgs.systemd}/bin/systemctl stop kmonad-keychron.service"
#   '';
# }
