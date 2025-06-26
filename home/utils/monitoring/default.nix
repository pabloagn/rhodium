{pkgs, ...}: {
  imports = [
    ./bottom.nix
    ./btop.nix
  ];

  home.packages = with pkgs; [
    lnav # Logfile navigator
    pv # Monitor progress using bars
    hyperfine # CLI benchmarking tool
    ts # Task spooler
  ];
}
