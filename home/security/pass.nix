{pkgs, ...}: {
  home.packages = with pkgs; [
    # Password Managers
    _1password-gui
    _1password-cli
    bitwarden-desktop
    bitwarden-cli
  ];
}
