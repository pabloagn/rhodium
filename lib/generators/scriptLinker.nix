{ config, lib, pkgs, ... }:

let
  pathGenerators = import ./pathGenerators.nix { inherit config lib pkgs; };
in

{
  linkScripts = { enable, sourceDirectory }:
    lib.mkIf enable {
      home.file."${pathGenerators.scriptPaths.user}".source =
        config.lib.file.mkOutOfStoreSymlink "${sourceDirectory}/scripts";

      # Ensure script directory exists
      home.activation.create-script-dirs = lib.hm.dag.entryAfter ["writeBoundary"] ''
        mkdir -p "$(dirname "${pathGenerators.scriptPaths.user}")"
      '';
    };
}
