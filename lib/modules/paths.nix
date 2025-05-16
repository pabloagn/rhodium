# lib/modules/paths.nix
# Core path definitions for the Rhodium system

{ lib, config ? null, flakeRoot ? null }:

let
  # Handle the case where config is not available (system-level)
  homeDir = if config != null then config.home.homeDirectory else "/home/$USER";
  username = if config != null then config.home.username else "$USER";
in rec {
  # Basic paths
  home = homeDir;
  user = username;

  # XDG directories (follow XDG specification)
  xdg = {
    bin = "${home}/.local/bin";
    cache = "${home}/.cache";
    config = "${home}/.config";
    data = "${home}/.local/share";
    state = "${home}/.local/state";
  };

  # Rhodium-specific paths
  rhodium = {
    root = if flakeRoot != null then flakeRoot else "${home}/rhodium";

    # User directories
    dirs = {
      assets = "${xdg.data}/rhodium/assets";
      scripts = "${xdg.bin}/rhodium/scripts";
    };

    # Asset subdirectories
    assets = {
      colors = "${rhodium.dirs.assets}/colors";
      fonts = "${rhodium.dirs.assets}/fonts";
      icons = "${rhodium.dirs.assets}/icons";
      sounds = "${rhodium.dirs.assets}/sounds";
      images = "${rhodium.dirs.assets}/images";
      wallpapers = "${rhodium.dirs.assets}/images/wallpapers";
      logos = "${rhodium.dirs.assets}/images/logos";
    };

    # Scripts subdirectories
    scripts = {
      desktop = "${rhodium.dirs.scripts}/desktop";
      system = "${rhodium.dirs.scripts}/system";
    };
  };
}
