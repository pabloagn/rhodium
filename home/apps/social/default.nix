{pkgs, ...}: {
  home.packages = with pkgs; [
    # --- Discord ---
    discordo
    discord

    # --- Mastodon ---
    mastodon

    # --- Matrix ---
    element-call
    element-desktop

    # --- Signal ---
    signal-desktop

    # --- Telegram ---
    telegram-desktop
  ];
}
