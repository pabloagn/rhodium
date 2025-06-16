{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    brightnessctl # Read & control device brightness
    wdisplays # GUI for exploring and setting monitor options
  ];
}
