{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Connecting Logitech devices to receivers
    solaar
  ];
}
