{pkgs, ...}: {
  home.packages = with pkgs; [
    via # GUI for adjusting RGB lighting
    cowsay # Generate ASCII pictures using a cow
    # disfetch # Neofetch successor
    fastfetch # Faster disfetch
    ascii # Interactive ASCII name and symbol chart
  ];
}
