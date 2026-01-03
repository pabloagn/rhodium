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
    pkgs._1password-gui # NOTE: Bumped to 8.11 from stable
    pkgs._1password-cli

    # --- Bitwarden ---
    # pkgs.bitwarden-desktop
    # pkgs.bitwarden-cli

    # --- Protonpass ---
    # pkgs.proton-pass
  ];
}
