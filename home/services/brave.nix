# Rhodium - Brave Binary Preloader Service
#
# Uses vmtouch to lock Brave binaries and shared libraries in RAM.
# This ensures instant startup by keeping all code in physical memory.
#
# How it works:
# - vmtouch memory-maps the Brave installation directory
# - Uses mlock() to pin pages in physical RAM (prevents swapping)
# - Runs as daemon, keeping files locked until service stops
# - When you launch Brave, binaries are already in RAM = instant startup
#
# Memory impact: ~200-400MB for Brave/Chromium libs (less than running Brave)
# This is NOT the "hidden window" hack - no Brave process runs
{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.userExtraServices.rh-brave-preload;
in
{
  options.userExtraServices.rh-brave-preload = {
    enable = mkEnableOption "Brave binary preloader using vmtouch (instant startup)";
  };

  config = mkIf cfg.enable {
    # Ensure vmtouch is available
    home.packages = [ pkgs.vmtouch ];

    systemd.user.services.rh-brave-preload = {
      Unit = {
        Description = "Brave binary preloader (vmtouch memory lock)";
        Documentation = "https://hoytech.com/vmtouch/";
        # Start early, before graphical session fully loads
        After = [ "basic.target" ];
      };
      Service = {
        Type = "simple";
        # -t: touch (load into page cache)
        # -l: lock pages in physical memory (mlock)
        # -q: quiet mode
        # -f: follow symlinks
        # Target the entire Brave package in nix store
        ExecStart = "${pkgs.vmtouch}/bin/vmtouch -tlqf ${pkgs.brave}";
        # vmtouch with -l blocks indefinitely, keeping files locked
        # When service stops, memory is released
        Restart = "on-failure";
        RestartSec = 5;
        # Nice value - low priority for the daemon itself
        Nice = 19;
        IOSchedulingClass = "idle";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
