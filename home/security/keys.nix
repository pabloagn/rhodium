{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # TODO: Clean this shit up
    # pass Keychain & GnuPG: Required by Proton Bridge
    pass
    gnupg
    # keychain

    gnome-keyring

  ];
}
