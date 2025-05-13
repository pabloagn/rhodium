# hosts/native/default.nix

{
  imports = [
    ./hardware-configuration.nix
    ../common
  ];

  networking.hostName = "native";
  
  mySystem.categories = {
    development.enable = true;
    desktop.wm.i3.enable = true;
  };
}
