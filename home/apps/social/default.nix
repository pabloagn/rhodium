{pkgs, ...}: {
  home.packages = with pkgs; [
    signal-desktop
    telegram-desktop

    # Discord
    discordo
    discord

    # Element
    element-call
    element-desktop

    # Mastodon
    mastodon
  ];
}
