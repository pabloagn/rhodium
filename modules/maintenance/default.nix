{ config, lib, ... }:

{
  # Garbage
  maintenance.garbageCollection = {
    enable = true;
    schedule = "weekly";
    deleteOlderThan = "14d";
  };
}
