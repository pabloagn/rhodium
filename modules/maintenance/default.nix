{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.maintenance.garbageCollection;
in
{
  options.maintenance.garbageCollection = {
    enable = mkEnableOption "Automatic Nix store garbage collection";

    schedule = mkOption {
      type = types.str;
      default = "weekly";
      description = "How often to run garbage collection (systemd timer format)";
      example = "daily";
    };

    deleteOlderThan = mkOption {
      type = types.str;
      default = "7d";
      description = "Delete generations older than this";
      example = "30d";
    };
  };

  config = mkIf cfg.enable {
    nix.gc = {
      automatic = true;
      dates = cfg.schedule;
      options = "--delete-older-than ${cfg.deleteOlderThan}";
    };
  };
}
