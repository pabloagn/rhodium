{
  users = {
    user_001 = {
      username = "pabloagn";
      fullName = "Pablo Aguirre";
      emailMain = "pablo.aguirre@protonmail.com";
      # TODO: Change description to the real name...or change fullName to be the actual full name (GDM is taking desc as name)
      description = "User 001";
      extraGroups = [ "wheel" "networkmanager" "docker" ];
      isNormalUser = true;
      shell = "fish";
      # hashedPassword = null;
      # initialPassword = "changeme";
    };
  };
}
