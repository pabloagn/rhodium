{pkgs, ...}: {
  imports = [
    ./fastfetch.nix
  ];

  home.packages = with pkgs; [
    via # GUI for adjusting RGB lighting
    cowsay # Generate ASCII pictures using a cow
    cmatrix # We all know what this is
    ascii # Interactive ASCII name and symbol chart
  ];
}
