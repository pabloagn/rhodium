# hosts/host-0001/default.nix

{ config, lib, pkgs, modulesPath, userData, hostData, rhodium, inputs, ... }:

{
  imports = [
    rhodium.system.defaults
    inputs.sops-nix.nixosModules.sops
  ];

  networking.hostName = hostData.hostname;

  rhodium.system = {
    core = {
      boot = {
        enable = true;
        kernelModules = [
          "amdgpu"
        ];
      };

      filesystem = {
        enable = true;
        mounts = hostData.fileSystems or { };
        swaps = hostData.swapDevices or [ ];
      };

      # groups = { };

      hardware = {
        audio.enable = true;
        bluetooth.enable = true;

        cpu = {
          enable = true;
          governor = "performance";
          intelMicrocode = false;
          amdMicrocode = true;
        };

        keyboard = {
          enable = true;
        };

        mouse = {
          enable = true;
          package.solaar = true;
        };

        printers = {
          enable = true;
        };

        video = {
          enable = true;
        };

        extra = {
          enableAsusKeyboardBacklightFix = true;
        };
      };

      networking = {
        enable = true;
      };

      security = {
        enable = true;

        gnomeKeyring = {
          enable = true;
        };

        sops = {
          enable = false;
        };
      };

      shell = {
        enable = true;
      };

      system = {
        enable = true;
      };

      users = {
        enable = true;
      };

      utils = {
        enable = true;
      };

    };

    desktop = {
      enable = true;

      wm = {
        hyprland = {
          enable = true;
          amdSpecificSetup = true;
        };
      };
    };

    development.enable = true;
  };
}
