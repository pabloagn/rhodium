{ config, pkgs, ... }:

{
  imports = [
    ./bar
    ./files
    ./fonts
    ./notifications
    # ./wm # TODO: This needs to be dealt with here as well declaratively based on hardware
  ];
}
