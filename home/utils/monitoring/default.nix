{pkgs, ...}: {
  imports = [
    ./disks.nix
    ./processes.nix
    ./networking.nix
    ./benchmarking.nix
  ];

  home.packages = with pkgs; [
    lnav # Logfile navigator
    pv # Monitor progress using bars
    hyperfine # CLI benchmarking tool
    ts # Task spooler
    bandwhich # Display network utilization
    bmon # Network bandwidth monitor
  ];
}
