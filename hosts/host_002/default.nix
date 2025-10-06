{
  host,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/boot/boot.nix
    ../../modules/services
    ../../modules/hardware
    ../../modules/shell
    ../../modules/security
    ../../modules/users
    ../../modules/manager
    ../../modules/desktop
    ../../modules/desktop/wm/niri/intel.nix
    ../../modules/integration
    ../../modules/virtualization
    ../../modules/virtualization/docker-nvidia.nix
    ../../modules/apps
    ../../modules/rules
    ../../modules/maintenance
    ../../modules/utils
  ];

  # Base
  # ---------------------------------
  boot.kernelPackages = pkgs.linuxPackages_6_12;
  networking = {
    hostName = host.hostname or "nixos";
    networkmanager.enable = true;
  };

  # Declaratively create the secret file.
  environment.etc."nixos/secrets/tailscale-authkey" = {
    source = "/home/pabloagn/alexandria-tailscale-authkey";
    mode = "0400";
    user = "root";
    group = "root";
  };

  # NOTE: Managed tailscale
  # -------------------------------------------------------------------------------
  services.tailscale = {
    enable = true;
    authKeyFile = "/etc/nixos/secrets/tailscale-authkey";
    extraUpFlags = [ "--ssh" ];
  };
  # -------------------------------------------------------------------------------

  # NOTE: Self-hosted headscale
  # -------------------------------------------------------------------------------
  # Enable the main Tailscale daemon only.
  # services.tailscale.enable = true;

  # Define the connection service but ensure it is not enabled by default.
  # The switch process will ignore this unit.
  # NOTE: This is crucial since otherwise a switch will hang forever
  # systemd.services.tailscale-autoconnect = {
  #   enable = false;
  #   description = "Connect to Headscale server (triggered by timer)";
  #
  #   # Dependencies to ensure it runs under the right conditions when triggered.
  #   after = [
  #     "network-online.target"
  #     "tailscaled.service"
  #   ];
  #   wants = [ "network-online.target" ];
  #
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = ''
  #       ${pkgs.tailscale}/bin/tailscale up \
  #         --authkey=file:/etc/nixos/secrets/tailscale-authkey \
  #         --login-server=https://headscale.rhodium.sh \
  #         --hostname=alexandria \
  #         --ssh
  #     '';
  #   };
  # };
  #
  # # Define and enable the timer. This is the only part the switch will start.
  # # The timer will then start the disabled service asynchronously.
  # systemd.timers.tailscale-autoconnect = {
  #   description = "Timer to connect to Headscale after boot/switch";
  #   wantedBy = [ "timers.target" ];
  #   timerConfig = {
  #     # Run 30 seconds after boot to ensure network stability.
  #     OnBootSec = "30s";
  #     # Also run 15 seconds after a switch completes.
  #     OnUnitActiveSec = "15s";
  #     Unit = "tailscale-autoconnect.service";
  #   };
  # };

  # ---------------------------------------------------------------------------------

  # Modules
  # ---------------------------------
  extraServices = {
    asusKeyboardBacklight.enable = false;
    laptopLid.enable = false;
  };
  extraRules = {
    keychronUdev.enable = true;
    hdmiAutoSwitch.enable = true;
  };
  maintenance.garbageCollection = {
    enable = true;
    schedule = "daily";
    deleteOlderThan = "30d";
  };

  # Extra Args
  # ---------------------------------
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "24.11";
}
