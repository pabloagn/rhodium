{ lib, ... }:

with lib;

{
  mkAutoModule =
    {
      name,
      description,
      type,
      packages ? [ ],
      programName ? name,
      programConfig ? { },
    }:
    {
      config,
      lib,
      pkgs,
      rhodiumLib,
      ...
    }:
    let
      # Get current file position
      pos = __curPos;
      filePath = pos.file;

      # Extract path components from file path
      # Example: "/nix/store/.../home/apps/media/audio/spotify.nix"
      # -> ["home" "apps" "media" "audio"]
      pathComponents =
        let
          # Remove .nix extension and get directory
          dirPath = dirOf filePath;
          # Split by "/" and find "home" index
          parts = splitString "/" dirPath;
          homeIndex = lib.lists.findFirstIndex (x: x == "home") null parts;
        in
        if homeIndex != null then
          lib.lists.drop homeIndex parts
        else
          [
            "home"
            "apps"
            "unknown"
          ]; # fallback

      # Build option path: home.apps.media.audio.spotify
      optionPath = pathComponents ++ [ name ];
      cfg = getAttrFromPath optionPath config;
    in
    {
      options = setAttrByPath optionPath {
        enable = mkEnableOption description;
      };

      config = mkIf cfg.enable (
        if type == "package" then
          {
            home.packages = if builtins.isFunction packages then packages pkgs else packages;
          }
        else if type == "program" then
          {
            programs.${programName} = {
              enable = true;
            } // programConfig;
          }
        else
          { }
      );
    };
}
