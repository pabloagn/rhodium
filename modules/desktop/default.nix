{ config, pkgs, ... }:

{
  imports = [
    ./bar
    ./files
    ./fonts
    ./notifications
    # ./wm # This is now being dealt with directly in the host config. Eventually we do conditionally.
  ];
}
