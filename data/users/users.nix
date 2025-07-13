{
  users = {
    user_001 = {
      username = "pabloagn";
      fullName = "Pablo Aguirre";
      emailMain = "pablo.aguirre@protonmail.com";
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "input"
        "uinput"
        "video"
      ]; # NOTE: uinput required by kmonad
      isNormalUser = true;
      shell = "fish";
    };
  };
}
