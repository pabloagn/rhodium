{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    solaar # Connecting Logitech devices to receivers
  ];
}
