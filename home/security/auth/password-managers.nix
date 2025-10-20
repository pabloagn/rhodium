{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  home.packages = [
    # --- 1Password ---
    # pkgs._1password-gui
    # pkgs-unstable._1password-gui-beta # NOTE: Required for now since wayland clipboard is in Beta version
    pkgs-unstable._1password-gui # NOTE: Current 8.11 follows unstable
    pkgs._1password-cli

    # --- Bitwarden ---
    # pkgs.bitwarden-desktop
    # pkgs.bitwarden-cli

    # --- Protonpass ---
    # pkgs.proton-pass
  ];
}
