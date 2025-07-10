{pkgs, ...}: {
  imports = [
    ./bottom.nix
    ./btop.nix
  ];

  home.packages = with pkgs; [
    procs # Rustified ps
  ];
}
