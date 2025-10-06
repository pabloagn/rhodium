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
  # Kernel version
  boot.kernelPackages = pkgs.linuxPackages_6_12; # Courtesy of fucking NVIDIA, they dont support latest kernel yet.

  # Host Configuration
  networking = {
    hostName = host.hostname or "nixos";
    networkmanager.enable = true;
  };

  # --- Tailscale Client Configuration for Alexandria ---

  # 1. Declaratively create the secret file during the system build.
  #    This requires the source file to exist at the specified path before building.
  environment.etc."nixos/secrets/tailscale-authkey" = {
    source = "/home/pabloagn/alexandria-tailscale-authkey";
    mode = "0400"; # Read-only for owner (root)
    user = "root";
    group = "root";
  };

  # 2. Configure the Tailscale client service.
  services.tailscale = {
    enable = true;
    # Point the client to your self-hosted Headscale server.
    loginServer = "https://headscale.rhodium.sh";
  };

  # 3. Modify the systemd service to automatically connect on startup.
  systemd.services.tailscaled.serviceConfig = {
    # After the tailscaled service starts, execute this command.
    ExecStartPost = ''
      ${pkgs.tailscale}/bin/tailscale up \
        --authkey=file:/etc/nixos/secrets/tailscale-authkey \
        --hostname=alexandria \
        --ssh
    '';
  };

  # ----------------------------------------------------

  # Modules
  # ---------------------------------
  # Extra Services
  extraServices = {
    asusKeyboardBacklight.enable = false;
    laptopLid.enable = false;
  };

  # Extra rules
  extraRules = {
    keychronUdev.enable = true;
    hdmiAutoSwitch.enable = true;
  };

  # Garbage override
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

  # Original derivation
  system.stateVersion = "24.11";
}
