{
  config,
  pkgs,
  lib,
  ...
}:
{
  virtualisation.vmVariant = {
    # VM resources
    virtualisation = {
      memorySize = 8192; # 8GB RAM
      cores = 4; # 4 CPU cores
      graphics = true; # Enable graphics
    };

    # VM test user
    users.users.vmtest = {
      isNormalUser = true;
      initialPassword = "test";
      group = "vmtest";
      extraGroups = [
        "wheel"
        "video"
        "audio"
        "networkmanager"
      ];
      shell = pkgs.bash;
    };

    users.groups.vmtest = { };

    # Auto-login for VM
    services.xserver.displayManager.autoLogin = {
      enable = true;
      user = "vmtest";
    };
  };
}
