# modules/core/hardware/cpu.nix

{ config, lib, hostData, ... }:

with lib;
let
  cfg = config.rhodium.system.hardware.cpu;
  hwCpu = hostData.hardware.cpu or { };
in
{
  options.rhodium.system.hardware.cpu = {
    enable = mkEnableOption "Rhodium CPU hardware configuration";

    governor = mkOption {
      type = types.enum [ "performance" "powersave" "schedutil" "ondemand" "conservative" "userspace" ];
      default = "performance";
      description = ''
        The CPU frequency scaling governor to use.
        'performance' keeps the CPU at its maximum frequency.
        'powersave' keeps the CPU at its minimum frequency.
        'schedutil' (recommended for newer kernels) uses scheduler-driven frequency scaling.
        'ondemand' and 'conservative' are older dynamic governors.
      '';
      example = "schedutil";
    };

    intelMicrocode = mkOption {
      type = types.bool;
      default = if hwCpu.vendor == "intel" then config.hardware.enableRedistributableFirmware else false;
      description = "Whether to enable Intel microcode updates. Defaults based on CPU vendor and enableRedistributableFirmware.";
    };

    amdMicrocode = mkOption {
      type = types.bool;
      default = if hwCpu.vendor == "amd" then config.hardware.enableRedistributableFirmware else false;
      description = "Whether to enable AMD microcode updates. Defaults based on CPU vendor and enableRedistributableFirmware.";
    };
  };

  config = mkIf cfg.enable {
    hardware.enableRedistributableFirmware = lib.mkIf (cfg.intelMicrocode || cfg.amdMicrocode) true;
    hardware.cpu.intel.updateMicrocode = cfg.intelMicrocode;
    hardware.cpu.amd.updateMicrocode = cfg.amdMicrocode;
    powerManagement.cpuFreqGovernor = cfg.governor;
  };
}
