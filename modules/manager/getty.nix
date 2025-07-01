{...}: {
  services.xserver.displayManager.gdm.enable = false;
  services.getty = {
    greetingLine = ''[[[ password ]]]'';
    helpLine = "";
  };
}
