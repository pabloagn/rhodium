{pkgs, ...}: {
  imports = [
    ./bottom.nix
    ./btop.nix
  ];

  home.packages = with pkgs; [
  ];
}
